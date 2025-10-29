import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template habit_card}
/// Tarjeta especializada para mostrar un hábito en Lumo.
/// Incluye título, descripción, progreso y streak.
/// {@endtemplate}
class HabitCard extends StatelessWidget {
  /// {@macro habit_card}
  const HabitCard({
    required this.title,
    this.description,
    this.streak = 0,
    this.progress = 0.0,
    this.icon,
    this.onTap,
    this.isCompleted = false,
    super.key,
  });

  /// Título del hábito
  final String title;

  /// Descripción opcional del hábito
  final String? description;

  /// Racha actual (días consecutivos)
  final int streak;

  /// Progreso del hábito (0.0 a 1.0)
  final double progress;

  /// Icono del hábito
  final IconData? icon;

  /// Callback cuando se toca la tarjeta
  final VoidCallback? onTap;

  /// Si el hábito está completado hoy
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LumoCard(
      onTap: onTap,
      child: Row(
        children: [
          // Icono o checkbox
          _buildLeading(),
          const SizedBox(width: AppSpacing.md),

          // Contenido principal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),

                // Descripción
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description!,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Progreso
                if (progress > 0) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _buildProgressBar(),
                ],
              ],
            ),
          ),

          // Streak
          if (streak > 0) ...[
            const SizedBox(width: AppSpacing.md),
            _buildStreak(),
          ],
        ],
      ),
    );
  }

  Widget _buildLeading() {
    if (isCompleted) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          color: AppColors.white,
          size: 24,
        ),
      );
    }

    if (icon != null) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.electricLightest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
      );
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: AppColors.electricLightest,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        minHeight: 6,
      ),
    );
  }

  Widget _buildStreak() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department,
            color: AppColors.warning,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: const TextStyle(
              color: AppColors.warning,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template habit_card_compact}
/// Versión compacta de HabitCard para listas densas.
/// {@endtemplate}
class HabitCardCompact extends StatelessWidget {
  /// {@macro habit_card_compact}
  const HabitCardCompact({
    required this.title,
    this.onTap,
    this.isCompleted = false,
    this.icon,
    super.key,
  });

  /// Título del hábito
  final String title;

  /// Callback cuando se toca
  final VoidCallback? onTap;

  /// Si está completado
  final bool isCompleted;

  /// Icono del hábito
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: isCompleted ? AppColors.primary : AppColors.tin,
            ),
            const SizedBox(width: AppSpacing.md),
            if (icon != null) ...[
              Icon(icon, size: 20, color: AppColors.tin),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                  color: isCompleted
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
