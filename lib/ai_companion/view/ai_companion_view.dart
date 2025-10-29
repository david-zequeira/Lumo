import 'package:ai_client/ai_client.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/ai_companion/ai_companion.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template ai_companion_view}
/// Main view for the AI Companion chat.
/// {@endtemplate}
class AiCompanionView extends StatelessWidget {
  /// {@macro ai_companion_view}
  const AiCompanionView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          l10n.aiCompanionTitle,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.black),
            onPressed: () {
              context
                  .read<AiCompanionBloc>()
                  .add(const AiCompanionConversationCleared());
            },
            tooltip: l10n.aiCompanionClearChat,
          ),
        ],
      ),
      body: const _ChatBody(),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AiCompanionBloc>().state;

    return switch (state.status) {
      AiCompanionStatus.initial ||
      AiCompanionStatus.loading =>
        const Center(child: CircularProgressIndicator()),
      AiCompanionStatus.failure => _ErrorView(error: state.error),
      AiCompanionStatus.ready ||
      AiCompanionStatus.streaming =>
        const _ChatView(),
    };
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<AiCompanionBloc>().state;

    return Column(
      children: [
        // Messages list
        Expanded(
          child: state.messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xlg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: AppColors.tin.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          l10n.aiCompanionEmptyState,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  reverse: true,
                  itemCount: state.messages.length +
                      (state.status == AiCompanionStatus.streaming ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show streaming message at the top (index 0)
                    if (index == 0 &&
                        state.status == AiCompanionStatus.streaming) {
                      return ChatMessageBubble(
                        message: state.streamingMessage,
                        isUser: false,
                        isStreaming: true,
                      );
                    }

                    // Adjust index for regular messages
                    final messageIndex =
                        state.status == AiCompanionStatus.streaming
                            ? index - 1
                            : index;
                    final reversedIndex =
                        state.messages.length - 1 - messageIndex;
                    final message = state.messages[reversedIndex];

                    return ChatMessageBubble(
                      message: message.content,
                      isUser: message.role == MessageRole.user,
                      timestamp: message.timestamp,
                    );
                  },
                ),
        ),

        // Input field
        ChatInput(
          enabled: state.status != AiCompanionStatus.streaming,
          onSend: (message) {
            context
                .read<AiCompanionBloc>()
                .add(AiCompanionMessageSent(message));
          },
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.aiCompanionError,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                error!,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            AppButton.primary(
              onPressed: () {
                context.read<AiCompanionBloc>().add(const AiCompanionStarted());
              },
              child: Text(l10n.aiCompanionRetry),
            ),
          ],
        ),
      ),
    );
  }
}
