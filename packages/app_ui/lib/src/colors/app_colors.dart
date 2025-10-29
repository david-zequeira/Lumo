import 'package:flutter/material.dart';

/// Defines the color palette for Lumo - AI-Powered Social Companion.
///
/// Paleta de colores centrada en tonalidades de verde que transmiten
/// esperanza, crecimiento y bienestar emocional.
abstract class AppColors {
  // ============================================================================
  // LUMO BRAND COLORS - Paleta Principal
  // ============================================================================

  /// Electric Green - Color primario principal de Lumo
  /// Transmite energía, esperanza y crecimiento
  static const Color primary = Color(0xFF3CC47C);
  static const Color electric = Color(0xFF3CC47C);

  /// Forest Green - Verde oscuro para contraste y elementos importantes
  /// Transmite estabilidad, confianza y naturaleza
  static const Color primaryDark = Color(0xFF1E392A);
  static const Color forest = Color(0xFF1E392A);

  /// Light Cream - Beige cálido para acentos y warmth
  /// Transmite calidez, comodidad y serenidad
  static const Color accent = Color(0xE9C893);
  static const Color light = Color(0xE9C893);

  /// Tin Gray - Gris medio para elementos secundarios
  /// Transmite neutralidad y balance
  static const Color secondaryGray = Color(0xFF828081);
  static const Color tin = Color(0xFF828081);

  // ============================================================================
  // COLORES BASE
  // ============================================================================

  /// Negro puro - Para texto en tema claro
  static const Color black = Color(0xFF000000);

  /// Blanco puro - Para texto en tema oscuro
  static const Color white = Color(0xFFFFFFFF);

  /// Transparente
  static const Color transparent = Color(0x00000000);

  // ============================================================================
  // BACKGROUNDS Y SURFACES
  // ============================================================================

  /// Background principal - Blanco puro para tema claro
  static const Color background = Color(0xFFFFFFFF);

  /// Background oscuro - Forest green con más profundidad
  static const Color darkBackground = Color(0xFF1E392A);

  /// Surface para cards y containers en tema claro
  /// Se diferencia sutilmente del blanco de fondo
  static const Color surface = Color(0xFFF5F5F6);
  static const Color cardBackground = Color(0xFFF5F5F6);

  /// Surface para cards en tema oscuro
  static const Color surfaceDark = Color(0xFF2A4838);

  /// Modal background en tema claro
  static const Color modalBackground = Color(0xFFF5F5F6);

  // ============================================================================
  // VARIACIONES DE VERDE (Para estados de hábitos, progreso, etc)
  // ============================================================================

  /// Verde claro - Para indicadores de progreso bajo
  static const Color electricLight = Color(0xFF6FD99B);

  /// Verde muy claro - Para fondos sutiles
  static const Color electricLightest = Color(0xFFE6F9F0);

  /// Verde oscuro intenso - Para enfatizar
  static const Color forestDark = Color(0xFF0F1D15);

  // ============================================================================
  // COLORES EMOCIONALES (Para tracking de emociones)
  // ============================================================================

  /// Feliz / Alegre - Amarillo cálido
  static const Color emotionHappy = Color(0xFFFBBF24);

  /// Tranquilo / Peaceful - Verde suave
  static const Color emotionCalm = Color(0xFF3CC47C);

  /// Energético / Motivado - Verde eléctrico brillante
  static const Color emotionEnergetic = Color(0xFF10B981);

  /// Ansioso / Preocupado - Naranja
  static const Color emotionAnxious = Color(0xFFF59E0B);

  /// Triste - Gris azulado
  static const Color emotionSad = Color(0xFF6B7280);

  /// Enojado - Rojo suave
  static const Color emotionAngry = Color(0xFFEF4444);

  // ============================================================================
  // COLORES SEMÁNTICOS (Estados de la app)
  // ============================================================================

  /// Éxito - Verde electric
  static const Color success = Color(0xFF3CC47C);

  /// Error - Rojo
  static const Color error = Color(0xFFEF4444);

  /// Warning - Naranja
  static const Color warning = Color(0xFFF59E0B);

  /// Info - Azul
  static const Color info = Color(0xFF3B82F6);

  // ============================================================================
  // COLORES DE TEXTO
  // ============================================================================

  /// Texto principal en tema claro
  static const Color textPrimary = Color(0xFF000000);

  /// Texto secundario en tema claro
  static const Color textSecondary = Color(0xFF828081);

  /// Texto disabled en tema claro
  static const Color textDisabled = Color(0xFFBDBDBD);

  /// Texto en tema oscuro
  static const Color textOnDark = Color(0xFFFFFFFF);

  /// Texto secundario en tema oscuro
  static const Color textSecondaryOnDark = Color(0xBDFFFFFF);

  // ============================================================================
  // INPUTS Y CONTROLES
  // ============================================================================

  /// Input hover
  static const Color inputHover = Color(0xFFE4E4E4);

  /// Input focused - Usa el verde primary
  static const Color inputFocused = Color(0xFF3CC47C);

  /// Input enabled
  static const Color inputEnabled = Color(0xFFF5F5F6);

  /// Input border
  static const Color inputBorder = Color(0xFFE0E0E0);

  // ============================================================================
  // ESTADOS Y EMPHASIS
  // ============================================================================

  /// High emphasis en tema claro
  static const Color highEmphasisSurface = Color(0xE6000000);

  /// Medium emphasis en tema claro
  static const Color mediumEmphasisSurface = Color(0x99000000);

  /// High emphasis en tema oscuro
  static const Color highEmphasisPrimary = Color(0xFCFFFFFF);

  /// Medium emphasis en tema oscuro
  static const Color mediumEmphasisPrimary = Color(0xBDFFFFFF);

  /// Medium high emphasis en tema oscuro
  static const Color mediumHighEmphasisPrimary = Color(0xE6FFFFFF);

  /// Medium high emphasis en tema claro
  static const Color mediumHighEmphasisSurface = Color(0xB3000000);

  // ============================================================================
  // BORDERS Y DIVIDERS
  // ============================================================================

  /// Border outline en tema claro
  static const Color borderOutline = Color(0x33000000);

  /// Outline en tema claro
  static const Color outlineLight = Color(0x33000000);

  /// Outline en tema oscuro
  static const Color outlineOnDark = Color(0x29FFFFFF);

  /// Divider en tema claro
  static const Color divider = Color(0xFFE0E0E0);

  // ============================================================================
  // ESTADOS DISABLED
  // ============================================================================

  /// Foreground disabled
  static const Color disabledForeground = Color(0x611B1B1B);

  /// Button disabled
  static const Color disabledButton = Color(0x1F000000);

  /// Surface disabled
  static const Color disabledSurface = Color(0xFFE0E0E0);

  // ============================================================================
  // COLORES LEGACY (Mantener temporalmente para compatibilidad)
  // ============================================================================
  
  /// Dark aqua - Reemplazado por primary pero mantenido para compatibilidad
  static const Color darkAqua = Color(0xFF3CC47C);
  
  /// Primary container
  static const Color primaryContainer = Color(0xFFE6F9F0);
  
  /// On-background
  static const Color onBackground = Color(0xFF1A1A1A);
  
  /// Gainsboro
  static const Color gainsboro = Color(0xFFDADCE0);
  
  /// Orange - Para warnings
  static const Color orange = Color(0xFFF59E0B);
  
  /// Blue - Reemplazado por primary
  static const Color blue = Color(0xFF3CC47C);
  
  /// Sky blue - Reemplazado por primary light
  static const Color skyBlue = Color(0xFF6FD99B);
  
  /// Ocean blue - Reemplazado por forest
  static const Color oceanBlue = Color(0xFF1E392A);
  
  /// Light black
  static const Color lightBlack = Color(0x8A000000);
  
  /// Blue dress - Reemplazado por primary
  static const Color blueDress = Color(0xFF3CC47C);
  
  /// Crystal blue - Reemplazado por electric light
  static const Color crystalBlue = Color(0xFF6FD99B);
  
  /// Pale sky
  static const Color paleSky = Color(0xFF828081);
  
  /// Pastel grey
  static const Color pastelGrey = Color(0xFFCCCCCC);
  
  /// Bright grey
  static const Color brightGrey = Color(0xFFEAEAEA);
  
  /// Rangoon green - Reemplazado por forest dark
  static const Color rangoonGreen = Color(0xFF0F1D15);
  
  /// Eerie black - Reemplazado por forest dark
  static const Color eerieBlack = Color(0xFF0F1D15);
  
  /// Liver
  static const Color liver = Color(0xFF4D4D4D);
  
  /// Red wine - Reemplazado por error
  static const Color redWine = Color(0xFFEF4444);
  
  /// Surface 2
  static const Color surface2 = Color(0xFFF5F5F6);
  
  /// Grey MaterialColor
  static const MaterialColor grey = MaterialColor(0xFF828081, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF828081),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    900: Color(0xFF212121),
  });
  
  /// Green MaterialColor
  static const MaterialColor green = MaterialColor(0xFF3CC47C, <int, Color>{
    50: Color(0xFFE6F9F0),
    100: Color(0xFFB3F0D5),
    200: Color(0xFF80E7BA),
    300: Color(0xFF4DDEA0),
    400: Color(0xFF3CC47C),
    500: Color(0xFF3CC47C),
    600: Color(0xFF2FA864),
    700: Color(0xFF238C4C),
    800: Color(0xFF177034),
    900: Color(0xFF0B541C),
  });
  
  /// Light blue MaterialColor  
  static const MaterialColor lightBlue = MaterialColor(0xFF6FD99B, <int, Color>{
    50: Color(0xFFE8F5EE),
    100: Color(0xFFC6E7D6),
    200: Color(0xFFA1D8BC),
    300: Color(0xFF7BC9A2),
    400: Color(0xFF6FD99B),
    500: Color(0xFF6FD99B),
    600: Color(0xFF5AC688),
    700: Color(0xFF47B374),
    800: Color(0xFF34A060),
    900: Color(0xFF21874D),
  });
  
  /// Teal MaterialColor
  static const MaterialColor teal = MaterialColor(0xFF3CC47C, <int, Color>{
    50: Color(0xFFE6F9F0),
    100: Color(0xFFB3F0D5),
    200: Color(0xFF80E7BA),
    300: Color(0xFF4DDEA0),
    400: Color(0xFF3CC47C),
    500: Color(0xFF3CC47C),
    600: Color(0xFF2FA864),
    700: Color(0xFF238C4C),
    800: Color(0xFF177034),
    900: Color(0xFF0B541C),
  });
  
  /// Yellow MaterialColor
  static const MaterialColor yellow = MaterialColor(0xFFFBBF24, <int, Color>{
    50: Color(0xFFFFFBEB),
    100: Color(0xFFFEF3C7),
    200: Color(0xFFFDE68A),
    300: Color(0xFFFCD34D),
    400: Color(0xFFFBBF24),
    500: Color(0xFFF59E0B),
    600: Color(0xFFD97706),
    700: Color(0xFFB45309),
    800: Color(0xFF92400E),
    900: Color(0xFF78350F),
  });
  
  /// Red MaterialColor
  static const MaterialColor red = MaterialColor(0xFFEF4444, <int, Color>{
    50: Color(0xFFFEF2F2),
    100: Color(0xFFFEE2E2),
    200: Color(0xFFFECACA),
    300: Color(0xFFFCA5A5),
    400: Color(0xFFF87171),
    500: Color(0xFFEF4444),
    600: Color(0xFFDC2626),
    700: Color(0xFFB91C1C),
    800: Color(0xFF991B1B),
    900: Color(0xFF7F1D1D),
  });
  
  /// Secondary color - Adaptado a paleta Lumo
  static const MaterialColor secondary = MaterialColor(0xFFE9C893, <int, Color>{
    50: Color(0xFFFFF9F0),
    100: Color(0xFFFFF3E0),
    200: Color(0xFFFFE7C2),
    300: Color(0xFFFADDA4),
    400: Color(0xFFF2D18B),
    500: Color(0xFFE9C893),
    600: Color(0xFFD4B27A),
    700: Color(0xFFBF9C61),
    800: Color(0xFFA98648),
    900: Color(0xFF8F6F2F),
  });
}
