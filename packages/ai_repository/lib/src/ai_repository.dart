import 'dart:convert';

import 'package:ai_client/ai_client.dart';
import 'package:clock/clock.dart';
import 'package:storage/storage.dart';

part 'conversation_storage.dart';

/// {@template ai_repository}
/// Repository for AI interactions and conversation management.
/// {@endtemplate}
class AIRepository {
  /// {@macro ai_repository}
  const AIRepository({
    required AIClient client,
    required ConversationStorage storage,
  }) : _client = client,
       _storage = storage;

  final AIClient _client;
  final ConversationStorage _storage;

  /// Sends a message and streams the response.
  ///
  /// The method:
  /// 1. Retrieves conversation history
  /// 2. Adds the user message to history
  /// 3. Streams the AI response in real-time
  /// 4. Saves the complete AI response to storage
  ///
  /// Throws [SendMessageFailure] if the request fails.
  Stream<String> sendMessage({
    required String message,
    required String conversationId,
  }) async* {
    try {
      // 1. Get conversation history
      final history = await _storage.getHistory(conversationId);

      // 2. Add user message to history
      final userMessage = AIMessage(
        content: message,
        role: MessageRole.user,
        timestamp: clock.now(), // ✅ VGV Pattern - testeable time
      );

      await _storage.addMessage(conversationId, userMessage);

      // 3. Stream AI response
      final responseBuffer = StringBuffer();

      await for (final chunk in _client.sendMessage(
        message: message,
        conversationId: conversationId,
        history: [...history, userMessage],
      )) {
        responseBuffer.write(chunk);
        yield chunk;
      }

      // 4. Save complete AI response
      final aiMessage = AIMessage(
        content: responseBuffer.toString(),
        role: MessageRole.assistant,
        timestamp: clock.now(),
      );

      await _storage.addMessage(conversationId, aiMessage);
    } catch (error, stackTrace) {
      // ✅ VGV Pattern - preserve stack trace
      Error.throwWithStackTrace(SendMessageFailure(error), stackTrace);
    }
  }

  /// Gets conversation history for the specified conversation ID.
  ///
  /// Returns an empty list if no conversation exists.
  ///
  /// Throws [GetConversationFailure] if retrieval fails.
  Future<List<AIMessage>> getConversation({
    required String conversationId,
  }) async {
    try {
      return await _storage.getHistory(conversationId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetConversationFailure(error), stackTrace);
    }
  }

  /// Clears all messages in the specified conversation.
  ///
  /// Throws [ClearConversationFailure] if the operation fails.
  Future<void> clearConversation({
    required String conversationId,
  }) async {
    try {
      await _storage.clearHistory(conversationId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ClearConversationFailure(error), stackTrace);
    }
  }

  /// Gets the ID of the last active conversation.
  ///
  /// Returns `null` if no conversation has been active.
  ///
  /// Throws [GetLastConversationFailure] if retrieval fails.
  Future<String?> getLastConversationId() async {
    try {
      return await _storage.getLastConversation();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        GetLastConversationFailure(error),
        stackTrace,
      );
    }
  }

  /// Sets the last active conversation ID.
  ///
  /// Throws [SetConversationFailure] if the operation fails.
  Future<void> setLastConversationId(String conversationId) async {
    try {
      await _storage.setLastConversation(conversationId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SetConversationFailure(error), stackTrace);
    }
  }
}
