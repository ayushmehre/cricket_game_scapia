import 'package:cricket_game_scapia/utils/app_constants.dart'; // Import AppConstants
import 'package:flutter/material.dart';

/// Central repository for reusable text styles used across the application.
class AppTextStyles {
  AppTextStyles._(); // Private constructor to prevent instantiation

  // --- Font Families --- (Could also be in AppConstants)
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

  // Base style for player status, color needs to be applied based on status
  static const TextStyle playerStatusBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(blurRadius: 1, color: Colors.black54)],
  );

  // --- Existing Styles ---
  static final TextStyle statusText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.indigo.shade900, // Non-const color requires final
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
          color: Colors.yellowAccent.withOpacity(0.7),
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
    color: AppConstants.numberButtonText, // Use color from AppConstants
  );

  // --- Start Playing Button ---
  static const TextStyle startButton = TextStyle(
    color: Colors.black, // Specific color for this button
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  // --- Dialog Styles ---
  // Base style, color determined dynamically in the dialog
  static const TextStyle dialogTitleBase = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    fontFamily: AppTextStyles.pacificoFontFamily, // Use existing constant
  );

  static const TextStyle dialogContent = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle dialogButtonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Specific color for this button
  );

  // Base styles
  static const TextStyle _base = TextStyle(
    fontFamily: 'Roboto', // Example font
    color: Colors.white,
  );

  static final TextStyle playerLabel = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.yellowAccent.shade100, // Example color
    letterSpacing: 1.2,
  );

  // --- Error/Fallback Style ---
  static final TextStyle errorText = TextStyle(
    color: AppConstants.errorForegroundColor,
    fontSize: 14, // Example size, adjust as needed
  );

  // Add other reusable text styles here
  // static const TextStyle buttonText = TextStyle(...);
}
