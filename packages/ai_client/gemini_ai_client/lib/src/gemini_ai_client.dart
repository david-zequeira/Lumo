import 'package:ai_client/ai_client.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// {@template gemini_ai_client}
/// Google Gemini implementation of [AIClient].
/// {@endtemplate}
class GeminiAIClient implements AIClient {
  /// {@macro gemini_ai_client}
  GeminiAIClient({
    required String apiKey,
    String modelName = 'gemini-1.5-flash',
  })  : _apiKey = apiKey,
        _modelName = modelName {
    _model = GenerativeModel(
      model: _modelName,
      apiKey: _apiKey,
    );
  }

  final String _apiKey;
  final String _modelName;
  late final GenerativeModel _model;

  @override
  Stream<String> sendMessage({
    required String message,
    required String conversationId,
    List<AIMessage>? history,
  }) async* {
    try {
      // Convert history to Gemini format
      final geminiHistory = history
              ?.where((msg) => msg.role != MessageRole.system)
              .map(
                (msg) => Content(
                  msg.role == MessageRole.user ? 'user' : 'model',
                  [TextPart(msg.content)],
                ),
              )
              .toList() ??
          [];

      final chat = _model.startChat(history: geminiHistory);
      final response = chat.sendMessageStream(
        Content.text(message),
      );

      await for (final chunk in response) {
        final text = chunk.text;
        if (text != null) {
          yield text;
        }
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendMessageFailure(error), stackTrace);
    }
  }

  @override
  Future<String> generateCompletion({
    required String prompt,
  }) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? '';
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        GenerateCompletionFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future<void> dispose() async {
    // Gemini doesn't require explicit disposal
  }
}
