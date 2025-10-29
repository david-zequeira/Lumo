import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template chat_message_bubble}
/// Widget for displaying a chat message bubble.
/// {@endtemplate}
class ChatMessageBubble extends StatelessWidget {
  /// {@macro chat_message_bubble}
  const ChatMessageBubble({
    required this.message,
    required this.isUser,
    this.timestamp,
    this.isStreaming = false,
    super.key,
  });

  /// Message content
  final String message;

  /// Whether this is a user message
  final bool isUser;

  /// Message timestamp
  final DateTime? timestamp;

  /// Whether this message is currently streaming
  final bool isStreaming;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: isUser ? AppColors.white : AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                      if (isStreaming) ...[
                        const SizedBox(height: AppSpacing.xs),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isUser ? AppColors.white : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (timestamp != null && !isStreaming) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    _formatTimestamp(timestamp!),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSpacing.sm),
            _buildAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isUser ? AppColors.primary : AppColors.electricLightest,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isUser ? Icons.person : Icons.auto_awesome,
        color: isUser ? AppColors.white : AppColors.primary,
        size: 20,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return DateFormat.Hm().format(timestamp);
    } else {
      return DateFormat('dd/MM HH:mm').format(timestamp);
    }
  }
}
