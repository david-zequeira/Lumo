import 'package:equatable/equatable.dart';

/// {@template ai_failure}
/// Base class for AI-related failures.
/// {@endtemplate}
abstract class AIFailure with EquatableMixin implements Exception {
  /// {@macro ai_failure}
  const AIFailure(this.error);

  /// The error object
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template send_message_failure}
/// Thrown when sending a message fails.
/// {@endtemplate}
class SendMessageFailure extends AIFailure {
  /// {@macro send_message_failure}
  const SendMessageFailure(super.error);
}

/// {@template get_conversation_failure}
/// Thrown when retrieving a conversation fails.
/// {@endtemplate}
class GetConversationFailure extends AIFailure {
  /// {@macro get_conversation_failure}
  const GetConversationFailure(super.error);
}

/// {@template generate_completion_failure}
/// Thrown when generating a completion fails.
/// {@endtemplate}
class GenerateCompletionFailure extends AIFailure {
  /// {@macro generate_completion_failure}
  const GenerateCompletionFailure(super.error);
}

/// {@template clear_conversation_failure}
/// Thrown when clearing a conversation fails.
/// {@endtemplate}
class ClearConversationFailure extends AIFailure {
  /// {@macro clear_conversation_failure}
  const ClearConversationFailure(super.error);
}

/// {@template set_conversation_failure}
/// Thrown when setting conversation ID fails.
/// {@endtemplate}
class SetConversationFailure extends AIFailure {
  /// {@macro set_conversation_failure}
  const SetConversationFailure(super.error);
}

/// {@template get_last_conversation_failure}
/// Thrown when getting last conversation fails.
/// {@endtemplate}
class GetLastConversationFailure extends AIFailure {
  /// {@macro get_last_conversation_failure}
  const GetLastConversationFailure(super.error);
}
