// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:ai_client/ai_client.dart';
import 'package:test/test.dart';

// Mock implementation for testing
class MockAIClient extends AIClient {
  const MockAIClient();

  @override
  Stream<String> sendMessage({
    required String message,
    required String conversationId,
    List<AIMessage>? history,
  }) async* {
    yield 'Test response';
  }

  @override
  Future<String> generateCompletion({required String prompt}) async {
    return 'Test completion';
  }

  @override
  Future<void> dispose() async {}
}

void main() {
  group('AIClient', () {
    test('can be implemented', () {
      const client = MockAIClient();
      expect(client, isNotNull);
      expect(client, isA<AIClient>());
    });
  });
}
