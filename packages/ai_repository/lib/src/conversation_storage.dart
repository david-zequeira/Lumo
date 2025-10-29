part of 'ai_repository.dart';

/// Storage keys for AI conversations.
/// ✅ VGV Pattern - centralized storage keys
abstract class ConversationStorageKeys {
  /// Prefix for conversation storage keys
  static const conversationPrefix = '__ai_conversation_';

  /// Key for the last active conversation
  static const lastConversationKey = '__last_ai_conversation__';
}

/// {@template conversation_storage}
/// Storage for AI conversations.
/// ✅ VGV Pattern - part of repository for cohesion
/// {@endtemplate}
class ConversationStorage {
  /// {@macro conversation_storage}
  const ConversationStorage({required Storage storage}) : _storage = storage;

  final Storage _storage;

  /// Gets conversation history for the specified conversation ID.
  ///
  /// Returns an empty list if no conversation exists.
  Future<List<AIMessage>> getHistory(String conversationId) async {
    final key = '${ConversationStorageKeys.conversationPrefix}$conversationId';
    final json = await _storage.read(key: key);

    if (json == null) return [];

    try {
      final List<dynamic> messagesJson = jsonDecode(json) as List<dynamic>;
      return messagesJson
          .map((e) => AIMessage.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Adds a message to the conversation.
  Future<void> addMessage(String conversationId, AIMessage message) async {
    final history = await getHistory(conversationId);
    history.add(message);

    final key = '${ConversationStorageKeys.conversationPrefix}$conversationId';
    await _storage.write(
      key: key,
      value: jsonEncode(history.map((m) => m.toJson()).toList()),
    );
  }

  /// Clears all messages in the conversation.
  Future<void> clearHistory(String conversationId) async {
    final key = '${ConversationStorageKeys.conversationPrefix}$conversationId';
    await _storage.write(key: key, value: jsonEncode([]));
  }

  /// Sets the last active conversation ID.
  Future<void> setLastConversation(String conversationId) async {
    await _storage.write(
      key: ConversationStorageKeys.lastConversationKey,
      value: conversationId,
    );
  }

  /// Gets the last active conversation ID.
  ///
  /// Returns `null` if no conversation has been active.
  Future<String?> getLastConversation() async {
    return _storage.read(
      key: ConversationStorageKeys.lastConversationKey,
    );
  }
}

