import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:lumo/l10n/l10n.dart';

/// Helper para obtener traducciones de emociones
extension EmotionL10nHelper on EmotionType {
  /// Obtiene el label traducido de la emoción
  String getLabel(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case EmotionType.happy:
        return l10n.emotionHappy;
      case EmotionType.calm:
        return l10n.emotionCalm;
      case EmotionType.energetic:
        return l10n.emotionEnergetic;
      case EmotionType.anxious:
        return l10n.emotionAnxious;
      case EmotionType.sad:
        return l10n.emotionSad;
      case EmotionType.angry:
        return l10n.emotionAngry;
    }
  }
}
