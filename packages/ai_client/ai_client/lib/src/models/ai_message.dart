import 'package:equatable/equatable.dart';

/// {@template message_role}
/// The role of the message sender.
/// {@endtemplate}
enum MessageRole {
  /// User message
  user,

  /// AI assistant message
  assistant,

  /// System message
  system,
}

/// {@template ai_message}
/// Represents a message in an AI conversation.
/// {@endtemplate}
class AIMessage extends Equatable {
  /// {@macro ai_message}
  const AIMessage({
    required this.content,
    required this.role,
    required this.timestamp,
    this.id,
  });

  /// Message ID
  final String? id;

  /// Message content
  final String content;

  /// Role of the sender
  final MessageRole role;

  /// When the message was created
  final DateTime timestamp;

  @override
  List<Object?> get props => [id, content, role, timestamp];

  /// Creates a copy with the specified properties
  AIMessage copyWith({
    String? id,
    String? content,
    MessageRole? role,
    DateTime? timestamp,
  }) {
    return AIMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'content': content,
        'role': role.name,
        'timestamp': timestamp.toIso8601String(),
      };

  /// Creates from JSON
  factory AIMessage.fromJson(Map<String, dynamic> json) {
    return AIMessage(
      id: json['id'] as String?,
      content: json['content'] as String,
      role: MessageRole.values.byName(json['role'] as String),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

