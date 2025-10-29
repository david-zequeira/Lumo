import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template lumo_card}
/// Tarjeta base de Lumo con el diseño característico de la app.
/// Usa el color surface (#F5F5F6) para diferenciarse del fondo blanco.
/// {@endtemplate}
class LumoCard extends StatelessWidget {
  /// {@macro lumo_card}
  const LumoCard({
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.elevation = 0,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    super.key,
  });

  /// El contenido de la tarjeta
  final Widget child;

  /// Padding interno
  final EdgeInsetsGeometry? padding;

  /// Margin externo
  final EdgeInsetsGeometry? margin;

  /// Callback cuando se toca la tarjeta
  final VoidCallback? onTap;

  /// Elevación de la sombra
  final double elevation;

  /// Radio de los bordes
  final BorderRadius? borderRadius;

  /// Color de fondo (por defecto usa surface)
  final Color? backgroundColor;

  /// Borde personalizado
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackground =
        isDark ? AppColors.surfaceDark : AppColors.surface;

    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: border,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: elevation * 4,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: card,
      );
    }

    return card;
  }
}

/// {@template lumo_card_elevated}
/// Variante de LumoCard con elevación pronunciada.
/// {@endtemplate}
class LumoCardElevated extends StatelessWidget {
  /// {@macro lumo_card_elevated}
  const LumoCardElevated({
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    super.key,
  });

  /// El contenido de la tarjeta
  final Widget child;

  /// Padding interno
  final EdgeInsetsGeometry? padding;

  /// Margin externo
  final EdgeInsetsGeometry? margin;

  /// Callback cuando se toca la tarjeta
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LumoCard(
      elevation: 4,
      padding: padding,
      margin: margin,
      onTap: onTap,
      backgroundColor: AppColors.white,
      child: child,
    );
  }
}

/// {@template lumo_card_outline}
/// Variante de LumoCard con borde y sin relleno.
/// {@endtemplate}
class LumoCardOutline extends StatelessWidget {
  /// {@macro lumo_card_outline}
  const LumoCardOutline({
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderColor,
    super.key,
  });

  /// El contenido de la tarjeta
  final Widget child;

  /// Padding interno
  final EdgeInsetsGeometry? padding;

  /// Margin externo
  final EdgeInsetsGeometry? margin;

  /// Callback cuando se toca la tarjeta
  final VoidCallback? onTap;

  /// Color del borde
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return LumoCard(
      padding: padding,
      margin: margin,
      onTap: onTap,
      backgroundColor: AppColors.transparent,
      border: Border.all(
        color: borderColor ?? AppColors.divider,
        width: 1.5,
      ),
      child: child,
    );
  }
}
