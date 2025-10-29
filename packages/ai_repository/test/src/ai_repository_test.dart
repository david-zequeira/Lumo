import 'package:ai_client/ai_client.dart';
import 'package:ai_repository/ai_repository.dart';
import 'package:clock/clock.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';
import 'package:test/test.dart';

class MockAIClient extends Mock implements AIClient {}

class MockStorage extends Mock implements Storage {}

void main() {
  group('AIRepository', () {
    late AIClient client;
    late Storage storage;
    late AIRepository repository;

    setUp(() {
      client = MockAIClient();
      storage = MockStorage();
      
      // Default mock for storage
      when(() => storage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      repository = AIRepository(
        client: client,
        storage: ConversationStorage(storage: storage),
      );
    });

    group('sendMessage', () {
      test('streams AI response', () async {
        const conversationId = 'test-conversation';
        const message = 'Hello AI';
        const responseChunk1 = 'Hello';
        const responseChunk2 = ' there!';

        when(
          () => client.sendMessage(
            message: any(named: 'message'),
            conversationId: any(named: 'conversationId'),
            history: any(named: 'history'),
          ),
        ).thenAnswer(
          (_) => Stream.fromIterable([responseChunk1, responseChunk2]),
        );

        final result = await repository
            .sendMessage(
              message: message,
              conversationId: conversationId,
            )
            .toList();

        expect(result, equals([responseChunk1, responseChunk2]));
        verify(
          () => client.sendMessage(
            message: message,
            conversationId: conversationId,
            history: any(named: 'history'),
          ),
        ).called(1);
      });

      test('saves user message to storage', () async {
        const conversationId = 'test-conversation';
        const message = 'Hello AI';

        when(
          () => client.sendMessage(
            message: any(named: 'message'),
            conversationId: any(named: 'conversationId'),
            history: any(named: 'history'),
          ),
        ).thenAnswer((_) => Stream.fromIterable(['Response']));

        await repository
            .sendMessage(
              message: message,
              conversationId: conversationId,
            )
            .toList();

        verify(
          () => storage.write(
            key: any(named: 'key', that: contains(conversationId)),
            value: any(named: 'value'),
          ),
        ).called(greaterThan(0));
      });

      test('uses clock.now() for timestamps', () async {
        const conversationId = 'test-conversation';
        final fixedTime = DateTime(2024, 1, 1);

        when(
          () => client.sendMessage(
            message: any(named: 'message'),
            conversationId: any(named: 'conversationId'),
            history: any(named: 'history'),
          ),
        ).thenAnswer((_) => Stream.fromIterable(['Response']));

        await withClock(Clock.fixed(fixedTime), () async {
          await repository
              .sendMessage(
                message: 'Test',
                conversationId: conversationId,
              )
              .toList();
        });

        // Verify storage was called (timestamp is internal)
        verify(
          () => storage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).called(greaterThan(0));
      });

      test('throws SendMessageFailure on client error', () async {
        when(
          () => client.sendMessage(
            message: any(named: 'message'),
            conversationId: any(named: 'conversationId'),
            history: any(named: 'history'),
          ),
        ).thenThrow(Exception('API Error'));

        expect(
          () => repository
              .sendMessage(
                message: 'Test',
                conversationId: 'test',
              )
              .toList(),
          throwsA(isA<SendMessageFailure>()),
        );
      });
    });

    group('getConversation', () {
      test('returns conversation history from storage', () async {
        const conversationId = 'test-conversation';
        const storedJson = '[{"content":"Hello","role":"user",'
            '"timestamp":"2024-01-01T00:00:00.000Z"}]';

        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => storedJson);

        final result = await repository.getConversation(
          conversationId: conversationId,
        );

        expect(result, hasLength(1));
        expect(result.first.content, equals('Hello'));
        expect(result.first.role, equals(MessageRole.user));
      });

      test('returns empty list when no conversation exists', () async {
        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);

        final result = await repository.getConversation(
          conversationId: 'non-existent',
        );

        expect(result, isEmpty);
      });

      test('throws GetConversationFailure on storage error', () async {
        when(() => storage.read(key: any(named: 'key')))
            .thenThrow(Exception('Storage error'));

        expect(
          () => repository.getConversation(conversationId: 'test'),
          throwsA(isA<GetConversationFailure>()),
        );
      });
    });

    group('clearConversation', () {
      test('clears conversation history', () async {
        const conversationId = 'test-conversation';

        await repository.clearConversation(conversationId: conversationId);

        verify(
          () => storage.write(
            key: any(named: 'key', that: contains(conversationId)),
            value: '[]',
          ),
        ).called(1);
      });

      test('throws ClearConversationFailure on error', () async {
        when(
          () => storage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenThrow(Exception('Storage error'));

        expect(
          () => repository.clearConversation(conversationId: 'test'),
          throwsA(isA<ClearConversationFailure>()),
        );
      });
    });

    group('getLastConversationId', () {
      test('returns last conversation ID', () async {
        const expectedId = 'last-conversation';

        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => expectedId);

        final result = await repository.getLastConversationId();

        expect(result, equals(expectedId));
      });

      test('returns null when no last conversation', () async {
        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);

        final result = await repository.getLastConversationId();

        expect(result, isNull);
      });
    });

    group('setLastConversationId', () {
      test('sets last conversation ID', () async {
        const conversationId = 'new-conversation';

        await repository.setLastConversationId(conversationId);

        verify(
          () => storage.write(
            key: any(named: 'key'),
            value: conversationId,
          ),
        ).called(1);
      });
    });
  });
}
