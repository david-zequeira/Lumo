import 'package:ai_client/src/models/models.dart';

/// {@template ai_client}
/// Abstract interface for AI clients.
/// {@endtemplate}
abstract class AIClient {
  /// {@macro ai_client}
  const AIClient();

  /// Sends a message and returns a stream of response chunks.
  ///
  /// The response is streamed in real-time as the AI generates it.
  ///
  /// Throws [SendMessageFailure] if the request fails.
  Stream<String> sendMessage({
    required String message,
    required String conversationId,
    List<AIMessage>? history,
  });

  /// Generates a completion for the given prompt.
  ///
  /// Returns the complete response as a single string.
  ///
  /// Throws [GenerateCompletionFailure] if the request fails.
  Future<String> generateCompletion({
    required String prompt,
  });

  /// Disposes resources used by the client.
  Future<void> dispose();
}
