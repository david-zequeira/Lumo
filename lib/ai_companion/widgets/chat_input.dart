import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template chat_input}
/// Input field for sending chat messages.
/// {@endtemplate}
class ChatInput extends StatefulWidget {
  /// {@macro chat_input}
  const ChatInput({
    required this.onSend,
    this.enabled = true,
    super.key,
  });

  /// Callback when a message is sent
  final ValueChanged<String> onSend;

  /// Whether the input is enabled
  final bool enabled;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    widget.onSend(message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: l10n.aiCompanionInputHint,
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.lg),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                onSubmitted: widget.enabled ? (_) => _handleSend() : null,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: widget.enabled ? AppColors.primary : AppColors.tin,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: AppColors.white),
                onPressed: widget.enabled ? _handleSend : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
