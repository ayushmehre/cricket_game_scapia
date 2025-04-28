import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:flutter/material.dart';

/// Central repository for reusable text styles used across the application.
class AppTextStyles {
  AppTextStyles._();

  // --- Font Families ---
  static const String digitalFontFamily = 'Digital-7';
  static const String pacificoFontFamily = 'Pacifico';
  static const String creepsterFontFamily = 'Creepster';

  // --- Scoreboard Styles ---
  static const TextStyle targetScore = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(blurRadius: 2, color: Colors.black54)],
  );

  static const TextStyle playerScore = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: digitalFontFamily,
    shadows: [
      Shadow(blurRadius: 2, color: Colors.black87, offset: Offset(1, 1)),
    ],
  );

  static const TextStyle playerStatusBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(blurRadius: 1, color: Colors.black54)],
  );

  // --- Existing Styles ---
  static final TextStyle statusText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 90, 198, 101),
    shadows: const [
      Shadow(blurRadius: 1, color: Colors.white, offset: Offset(1, 1)),
    ],
  );

  static const TextStyle headingGold = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle timerText = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle howToPlayHeadingFallback = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle getGameTitleStyle(BuildContext context, double glowValue) {
    final baseStyle = Theme.of(context).textTheme.displayMedium;
    final effectiveStyle =
        baseStyle?.copyWith(fontFamily: pacificoFontFamily) ??
        gameTitleFallback;

    return effectiveStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: glowValue,
          color: Colors.yellowAccent.withAlpha(179),
          offset: Offset.zero,
        ),
        Shadow(
          blurRadius: glowValue * 1.5,
          color: Colors.orangeAccent.withOpacity(0.5),
          offset: Offset.zero,
        ),
      ],
    );
  }

  static const TextStyle gameTitleFallback = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: pacificoFontFamily,
  );

  // --- Number Input Grid Styles ---
  static const TextStyle numberButton = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppConstants.numberButtonText,
  );

  // --- Start Playing Button ---
  static const TextStyle startButton = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  // --- Dialog Styles ---
  static const TextStyle dialogTitleBase = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    fontFamily: AppTextStyles.pacificoFontFamily,
    color: Colors.white,
  );

  static const TextStyle dialogContent = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle dialogButtonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // --- Base styles ---
  static const TextStyle _base = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
  );

  static final TextStyle playerLabel = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.yellowAccent.shade100,
    letterSpacing: 1.2,
  );

  static final TextStyle playerRoleText = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle turnInfoText = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(blurRadius: 2, color: Colors.black54, offset: Offset(1, 1)),
    ],
  );

  // --- Error/Fallback Style ---
  static final TextStyle errorText = TextStyle(
    color: AppConstants.errorForegroundColor,
    fontSize: 14,
  );
}
