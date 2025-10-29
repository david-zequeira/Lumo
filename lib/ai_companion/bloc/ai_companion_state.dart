part of 'ai_companion_bloc.dart';

/// {@template ai_companion_status}
/// Status of the AI companion chat.
/// {@endtemplate}
enum AiCompanionStatus {
  /// Initial state
  initial,

  /// Loading conversation history
  loading,

  /// Ready to send/receive messages
  ready,

  /// Currently receiving a streaming response
  streaming,

  /// An error occurred
  failure,
}

/// {@template ai_companion_state}
/// State for the AI companion chat.
/// {@endtemplate}
final class AiCompanionState extends Equatable {
  /// {@macro ai_companion_state}
  const AiCompanionState({
    this.status = AiCompanionStatus.initial,
    this.messages = const [],
    this.conversationId,
    this.streamingMessage = '',
    this.error,
  });

  /// Current status
  final AiCompanionStatus status;

  /// Conversation messages
  final List<AIMessage> messages;

  /// Current conversation ID
  final String? conversationId;

  /// Message being streamed (partial AI response)
  final String streamingMessage;

  /// Error message if status is failure
  final String? error;

  @override
  List<Object?> get props => [
        status,
        messages,
        conversationId,
        streamingMessage,
        error,
      ];

  /// Creates a copy with the specified properties
  AiCompanionState copyWith({
    AiCompanionStatus? status,
    List<AIMessage>? messages,
    String? conversationId,
    String? streamingMessage,
    String? error,
  }) {
    return AiCompanionState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      streamingMessage: streamingMessage ?? this.streamingMessage,
      error: error ?? this.error,
    );
  }
}
