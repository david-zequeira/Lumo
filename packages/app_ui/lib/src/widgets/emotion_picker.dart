import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Tipos de emociones disponibles en Lumo
enum EmotionType {
  /// Feliz / Alegre
  happy,

  /// Tranquilo / En paz
  calm,

  /// Energético / Motivado
  energetic,

  /// Ansioso / Preocupado
  anxious,

  /// Triste
  sad,

  /// Enojado
  angry,
}

/// Extensión para obtener propiedades de las emociones
extension EmotionTypeX on EmotionType {
  /// Color asociado a la emoción
  Color get color {
    switch (this) {
      case EmotionType.happy:
        return AppColors.emotionHappy;
      case EmotionType.calm:
        return AppColors.emotionCalm;
      case EmotionType.energetic:
        return AppColors.emotionEnergetic;
      case EmotionType.anxious:
        return AppColors.emotionAnxious;
      case EmotionType.sad:
        return AppColors.emotionSad;
      case EmotionType.angry:
        return AppColors.emotionAngry;
    }
  }

  /// Emoji asociado a la emoción
  String get emoji {
    switch (this) {
      case EmotionType.happy:
        return '😊';
      case EmotionType.calm:
        return '😌';
      case EmotionType.energetic:
        return '⚡';
      case EmotionType.anxious:
        return '😰';
      case EmotionType.sad:
        return '😢';
      case EmotionType.angry:
        return '😠';
    }
  }

  /// Nombre de la emoción (sin traducción - solo para identificación interna)
  String get label {
    return name;
  }
}

/// {@template emotion_picker}
/// Widget para seleccionar el estado emocional del usuario.
/// Presenta opciones visuales con emojis y colores.
/// {@endtemplate}
class EmotionPicker extends StatelessWidget {
  /// {@macro emotion_picker}
  const EmotionPicker({
    required this.onEmotionSelected,
    this.selectedEmotion,
    this.layout = EmotionPickerLayout.grid,
    super.key,
  });

  /// Callback cuando se selecciona una emoción
  final ValueChanged<EmotionType> onEmotionSelected;

  /// Emoción actualmente seleccionada
  final EmotionType? selectedEmotion;

  /// Disposición de las emociones
  final EmotionPickerLayout layout;

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      EmotionPickerLayout.grid => _buildGrid(),
      EmotionPickerLayout.horizontal => _buildHorizontal(),
      EmotionPickerLayout.compact => _buildCompact(),
    };
  }

  Widget _buildGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      children: EmotionType.values
          .map((emotion) => _EmotionTile(
                emotion: emotion,
                isSelected: emotion == selectedEmotion,
                onTap: () => onEmotionSelected(emotion),
              ))
          .toList(),
    );
  }

  Widget _buildHorizontal() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: EmotionType.values
            .map((emotion) => Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: _EmotionTile(
                    emotion: emotion,
                    isSelected: emotion == selectedEmotion,
                    onTap: () => onEmotionSelected(emotion),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCompact() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: EmotionType.values
          .map((emotion) => _EmotionChip(
                emotion: emotion,
                isSelected: emotion == selectedEmotion,
                onTap: () => onEmotionSelected(emotion),
              ))
          .toList(),
    );
  }
}

/// Layout options para EmotionPicker
enum EmotionPickerLayout {
  /// Grid de 3 columnas
  grid,

  /// Lista horizontal scrollable
  horizontal,

  /// Chips compactos con wrap
  compact,
}

class _EmotionTile extends StatelessWidget {
  const _EmotionTile({
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  final EmotionType emotion;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? emotion.color.withValues(alpha: 0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? emotion.color : AppColors.divider,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            emotion.emoji,
            style: const TextStyle(fontSize: 38),
          ),
        ),
      ),
    );
  }
}

class _EmotionChip extends StatelessWidget {
  const _EmotionChip({
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  final EmotionType emotion;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? emotion.color.withValues(alpha: 0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? emotion.color : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          emotion.emoji,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}

/// {@template mood_indicator}
/// Indicador simple de estado de ánimo con emoji y color.
/// {@endtemplate}
class MoodIndicator extends StatelessWidget {
  /// {@macro mood_indicator}
  const MoodIndicator({
    required this.emotion,
    this.size = 48,
    this.showLabel = true,
    super.key,
  });

  /// Emoción a mostrar
  final EmotionType emotion;

  /// Tamaño del indicador
  final double size;

  /// Si muestra el label
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: emotion.color.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: emotion.color,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              emotion.emoji,
              style: TextStyle(fontSize: size * 0.5),
            ),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            emotion.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: emotion.color,
            ),
          ),
        ],
      ],
    );
  }
}
