// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:ai_client/ai_client.dart';
import 'package:gemini_ai_client/gemini_ai_client.dart';
import 'package:test/test.dart';

void main() {
  group('GeminiAIClient', () {
    late GeminiAIClient client;

    setUp(() {
      client = GeminiAIClient(
        apiKey: 'test-api-key',
      );
    });

    test('can be instantiated', () {
      expect(client, isNotNull);
    });

    test('implements AIClient', () {
      expect(client, isA<AIClient>());
    });

    test('uses correct default model name', () {
      final clientWithDefaults = GeminiAIClient(
        apiKey: 'test-key',
      );
      expect(clientWithDefaults, isNotNull);
    });

    test('accepts custom model name', () {
      final customClient = GeminiAIClient(
        apiKey: 'test-key',
        modelName: 'gemini-pro',
      );
      expect(customClient, isNotNull);
    });
  });
}
