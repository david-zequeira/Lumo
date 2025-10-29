import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template emotion_check_in_card}
/// Tarjeta para que el usuario registre su estado emocional del día.
/// {@endtemplate}
class EmotionCheckInCard extends StatelessWidget {
  /// {@macro emotion_check_in_card}
  const EmotionCheckInCard({
    required this.onEmotionSelected,
    this.currentEmotion,
    super.key,
  });

  /// Callback cuando se selecciona una emoción
  final ValueChanged<EmotionType> onEmotionSelected;

  /// Emoción actual del día (si ya se registró)
  final EmotionType? currentEmotion;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final hasCheckedIn = currentEmotion != null;

    return LumoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasCheckedIn
                          ? l10n.emotionCheckInTitleUpdate
                          : l10n.emotionCheckInTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (!hasCheckedIn)
                      Text(
                        l10n.emotionCheckInSubtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Selector de emociones
          EmotionPicker(
            onEmotionSelected: onEmotionSelected,
            selectedEmotion: currentEmotion,
            layout: EmotionPickerLayout.compact,
          ),
        ],
      ),
    );
  }
}
