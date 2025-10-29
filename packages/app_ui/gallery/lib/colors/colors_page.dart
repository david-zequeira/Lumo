import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ColorsPage());
  }

  @override
  Widget build(BuildContext context) {
    const colorItems = [
      // Colores Principales de Lumo
      _ColorItem(name: 'Primary (Electric)', color: AppColors.primary),
      _ColorItem(name: 'Primary Dark (Forest)', color: AppColors.forest),
      _ColorItem(name: 'Accent (Light)', color: AppColors.accent),
      _ColorItem(name: 'Secondary (Tin)', color: AppColors.tin),
      
      // Backgrounds y Surfaces
      _ColorItem(name: 'Background', color: AppColors.background),
      _ColorItem(name: 'Surface (Cards)', color: AppColors.surface),
      _ColorItem(name: 'Dark Background', color: AppColors.darkBackground),
      _ColorItem(name: 'Surface Dark', color: AppColors.surfaceDark),
      
      // Variaciones de Verde
      _ColorItem(name: 'Electric Light', color: AppColors.electricLight),
      _ColorItem(name: 'Electric Lightest', color: AppColors.electricLightest),
      _ColorItem(name: 'Forest Dark', color: AppColors.forestDark),
      
      // Colores Emocionales
      _ColorItem(name: 'Emotion Happy', color: AppColors.emotionHappy),
      _ColorItem(name: 'Emotion Calm', color: AppColors.emotionCalm),
      _ColorItem(name: 'Emotion Energetic', color: AppColors.emotionEnergetic),
      _ColorItem(name: 'Emotion Anxious', color: AppColors.emotionAnxious),
      _ColorItem(name: 'Emotion Sad', color: AppColors.emotionSad),
      _ColorItem(name: 'Emotion Angry', color: AppColors.emotionAngry),
      
      // Colores Semánticos
      _ColorItem(name: 'Success', color: AppColors.success),
      _ColorItem(name: 'Error', color: AppColors.error),
      _ColorItem(name: 'Warning', color: AppColors.warning),
      _ColorItem(name: 'Info', color: AppColors.info),
      
      // Colores de Texto
      _ColorItem(name: 'Text Primary', color: AppColors.textPrimary),
      _ColorItem(name: 'Text Secondary', color: AppColors.textSecondary),
      _ColorItem(name: 'Text on Dark', color: AppColors.textOnDark),
      
      // Base
      _ColorItem(name: 'Black', color: AppColors.black),
      _ColorItem(name: 'White', color: AppColors.white),
      
      // Inputs
      _ColorItem(name: 'Input Enabled', color: AppColors.inputEnabled),
      _ColorItem(name: 'Input Focused', color: AppColors.inputFocused),
      _ColorItem(name: 'Input Border', color: AppColors.inputBorder),
      
      // Dividers
      _ColorItem(name: 'Divider', color: AppColors.divider),
      _ColorItem(name: 'Border Outline', color: AppColors.borderOutline),
      
      // Secondary Material Color
      _ColorItem(name: 'Secondary Material', color: AppColors.secondary),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lumo Color Palette')),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorItems.length,
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(name),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: color is MaterialColor
                  ? _MaterialColorView(color: color as MaterialColor)
                  : _ColorSquare(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialColorView extends StatelessWidget {
  const _MaterialColorView({required this.color});

  static const List<int> shades = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
  ];

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: shades.map((shade) {
        return _ColorSquare(color: color[shade]!);
      }).toList(),
    );
  }
}

class _ColorSquare extends StatelessWidget {
  const _ColorSquare({required this.color});

  final Color color;

  TextStyle get textStyle {
    return TextStyle(
      color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
    );
  }

  String get hexCode {
    final hex = color.value.toRadixString(16);
    if (hex.length <= 2) {
      return '--';
    } else {
      return '#${hex.substring(2).toUpperCase()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Stack(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color, border: Border.all()),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(child: Text(hexCode, style: textStyle)),
          ),
        ],
      ),
    );
  }
}
