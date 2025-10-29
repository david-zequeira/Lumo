import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template ai_quick_access_card}
/// Tarjeta de acceso rápido al AI Companion de Lumo.
/// {@endtemplate}
class AIQuickAccessCard extends StatelessWidget {
  /// {@macro ai_quick_access_card}
  const AIQuickAccessCard({
    required this.onTap,
    this.lastMessage,
    super.key,
  });

  /// Callback cuando se toca la tarjeta
  final VoidCallback onTap;

  /// Último mensaje del AI (opcional)
  final String? lastMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return LumoCard(
      onTap: onTap,
      child: Row(
        children: [
          // Icono del AI
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.forest],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.aiCompanionTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.aiCompanionOnline,
                        style: const TextStyle(
                          color: AppColors.success,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  lastMessage ?? l10n.aiCompanionDefaultMessage,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Flecha
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.tin,
          ),
        ],
      ),
    );
  }
}
