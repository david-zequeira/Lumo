part of 'ai_companion_bloc.dart';

sealed class AiCompanionEvent extends Equatable {
  const AiCompanionEvent();

  @override
  List<Object?> get props => [];
}

/// {@template ai_companion_started}
/// Event emitted when the AI companion chat is started.
/// {@endtemplate}
final class AiCompanionStarted extends AiCompanionEvent {
  /// {@macro ai_companion_started}
  const AiCompanionStarted();
}

/// {@template ai_companion_message_sent}
/// Event emitted when a user sends a message.
/// {@endtemplate}
final class AiCompanionMessageSent extends AiCompanionEvent {
  /// {@macro ai_companion_message_sent}
  const AiCompanionMessageSent(this.message);

  /// The message content
  final String message;

  @override
  List<Object> get props => [message];
}

/// {@template ai_companion_conversation_cleared}
/// Event emitted when the conversation is cleared.
/// {@endtemplate}
final class AiCompanionConversationCleared extends AiCompanionEvent {
  /// {@macro ai_companion_conversation_cleared}
  const AiCompanionConversationCleared();
}

/// {@template ai_companion_conversation_loaded}
/// Event emitted when a specific conversation is loaded.
/// {@endtemplate}
final class AiCompanionConversationLoaded extends AiCompanionEvent {
  /// {@macro ai_companion_conversation_loaded}
  const AiCompanionConversationLoaded(this.conversationId);

  /// The conversation ID to load
  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}
