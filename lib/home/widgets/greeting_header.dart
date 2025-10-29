import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template greeting_header}
/// Header con saludo personalizado y hora del día.
/// {@endtemplate}
class GreetingHeader extends StatelessWidget {
  /// {@macro greeting_header}
  const GreetingHeader({
    required this.userName,
    super.key,
  });

  /// Nombre del usuario
  final String userName;

  String _getGreeting(BuildContext context) {
    final l10n = context.l10n;
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 18) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getGreeting(context),
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            userName.isEmpty ? l10n.greetingWelcome : userName,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
