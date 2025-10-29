import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template daily_summary_card}
/// Tarjeta de resumen diario que muestra el progreso de hábitos del día.
/// {@endtemplate}
class DailySummaryCard extends StatelessWidget {
  /// {@macro daily_summary_card}
  const DailySummaryCard({
    required this.completedHabits,
    required this.totalHabits,
    this.onTap,
    super.key,
  });

  /// Número de hábitos completados hoy
  final int completedHabits;

  /// Total de hábitos del día
  final int totalHabits;

  /// Callback cuando se toca la tarjeta
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final percentage =
        totalHabits > 0 ? (completedHabits / totalHabits * 100).toInt() : 0;

    return LumoCard(
      onTap: onTap,
      child: Row(
        children: [
          // Anillo de progreso
          DailyProgressRing(
            completedHabits: completedHabits,
            totalHabits: totalHabits,
            size: 80,
          ),
          const SizedBox(width: AppSpacing.lg),

          // Información
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dailyProgressTitle,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$completedHabits ${l10n.ofLabel} $totalHabits ${l10n.habitsCompleted}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Barra de progreso
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: totalHabits > 0 ? completedHabits / totalHabits : 0,
                    backgroundColor: AppColors.electricLightest,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),

          // Porcentaje
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$percentage%',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
