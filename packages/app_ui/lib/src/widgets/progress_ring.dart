import 'dart:math' as math;

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template progress_ring}
/// Anillo de progreso circular animado para mostrar el avance de hábitos.
/// Usa los colores de Lumo y puede mostrar porcentaje en el centro.
/// {@endtemplate}
class ProgressRing extends StatelessWidget {
  /// {@macro progress_ring}
  const ProgressRing({
    required this.progress,
    this.size = 120,
    this.strokeWidth = 12,
    this.backgroundColor,
    this.progressColor,
    this.showPercentage = true,
    this.centerWidget,
    this.animated = true,
    super.key,
  });

  /// Progreso actual (0.0 a 1.0)
  final double progress;

  /// Tamaño del anillo
  final double size;

  /// Grosor del anillo
  final double strokeWidth;

  /// Color de fondo del anillo
  final Color? backgroundColor;

  /// Color del progreso
  final Color? progressColor;

  /// Si muestra el porcentaje en el centro
  final bool showPercentage;

  /// Widget personalizado para el centro (override showPercentage)
  final Widget? centerWidget;

  /// Si el progreso se anima
  final bool animated;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDark ? AppColors.surfaceDark : AppColors.electricLightest);
    final fgColor = progressColor ?? AppColors.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Anillo de fondo
          CustomPaint(
            size: Size(size, size),
            painter: _ProgressRingPainter(
              progress: 1.0,
              strokeWidth: strokeWidth,
              color: bgColor,
            ),
          ),

          // Anillo de progreso
          TweenAnimationBuilder<double>(
            duration:
                animated ? const Duration(milliseconds: 1000) : Duration.zero,
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 0, end: progress),
            builder: (context, value, _) => CustomPaint(
              size: Size(size, size),
              painter: _ProgressRingPainter(
                progress: value,
                strokeWidth: strokeWidth,
                color: fgColor,
              ),
            ),
          ),

          // Contenido central
          if (centerWidget != null)
            centerWidget!
          else if (showPercentage)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: size * 0.2,
                    fontWeight: FontWeight.bold,
                    color: fgColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  final double progress;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Dibujar el arco
    const startAngle = -math.pi / 2; // Empezar desde arriba
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// {@template progress_ring_with_icon}
/// Variante de ProgressRing con icono en el centro.
/// {@endtemplate}
class ProgressRingWithIcon extends StatelessWidget {
  /// {@macro progress_ring_with_icon}
  const ProgressRingWithIcon({
    required this.progress,
    required this.icon,
    this.size = 120,
    this.strokeWidth = 12,
    this.iconSize,
    this.iconColor,
    super.key,
  });

  /// Progreso (0.0 a 1.0)
  final double progress;

  /// Icono a mostrar
  final IconData icon;

  /// Tamaño del widget
  final double size;

  /// Grosor del anillo
  final double strokeWidth;

  /// Tamaño del icono
  final double? iconSize;

  /// Color del icono
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ProgressRing(
      progress: progress,
      size: size,
      strokeWidth: strokeWidth,
      showPercentage: false,
      centerWidget: Icon(
        icon,
        size: iconSize ?? size * 0.35,
        color: iconColor ?? AppColors.primary,
      ),
    );
  }
}

/// {@template daily_progress_ring}
/// Anillo de progreso para el resumen diario.
/// Muestra el progreso de hábitos completados del día.
/// {@endtemplate}
class DailyProgressRing extends StatelessWidget {
  /// {@macro daily_progress_ring}
  const DailyProgressRing({
    required this.completedHabits,
    required this.totalHabits,
    this.size = 100,
    super.key,
  });

  /// Número de hábitos completados
  final int completedHabits;

  /// Total de hábitos del día
  final int totalHabits;

  /// Tamaño del widget
  final double size;

  @override
  Widget build(BuildContext context) {
    final progress = totalHabits > 0 ? completedHabits / totalHabits : 0.0;

    return ProgressRing(
      progress: progress,
      size: size,
      showPercentage: false,
      centerWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$completedHabits',
            style: TextStyle(
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            'de $totalHabits',
            style: TextStyle(
              fontSize: size * 0.12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
