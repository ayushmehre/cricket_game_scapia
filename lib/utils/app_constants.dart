import 'package:flutter/material.dart'; // Add Material import for Color

/// Defines constant values used across the application.
class AppConstants {
  AppConstants._(); // Prevents instantiation

  // Durations
  static const Duration overlayFadeDuration = Duration(milliseconds: 300);
  static const Duration overlayHoldDuration = Duration(seconds: 2);
  static const Duration overlayTransitionDelay = Duration(milliseconds: 500);
  static const Duration resultOverlayHoldDuration = Duration(seconds: 3);
  static const Duration animationDelay = Duration(
    milliseconds: 700,
  ); // Delay after animation trigger
  static const Duration timerTickDuration = Duration(seconds: 1);
  static const Duration dialogShowDelay = Duration(milliseconds: 500);

  // Gameplay
  static const int maxTimerSeconds = 10;
  static const int maxBattingNumber = 6;
  static const int numberGridColumnCount = 3;
  static const int timerWarningThreshold = 3;

  // UI Sizes (Example)
  static const double overlayImageHeightFactor = 0.4;
  static const double timerWidgetSize = 60.0;
  static const double scoreboardPadding = 16.0;
  static const double scoreboardHorizontalMargin = 16.0;
  static const double scoreboardVerticalMargin = 8.0;
  static const double scoreboardBorderRadius = 10.0;
  static const double numberGridPadding = 30.0;
  static const double numberGridVerticalPadding = 10.0;
  static const double numberGridSpacing = 15.0;
  static const double numberGridAspectRatio = 1.5;
  static const double timerStrokeWidth = 5.0;
  static const double scoreDisplaySpacingSmall = 4.0;
  static const double scoreDisplaySpacingMedium = 8.0;
  static const double dialogContentSpacing = 10.0;
  static const double statusTextVerticalPadding = 10.0;
  static const double overlayErrorIconSize = 60.0;
  static const double turnInfoBoxPadding = 12.0;
  static const double turnInfoBoxRadius = 8.0;

  // UI Colors (Consider a separate AppColors class if this grows)
  static const Color scoreboardGradientColor1 = Color(0xFF8B4513);
  static const Color scoreboardGradientColor2 = Color(0xFFA0522D);
  static final Color scoreboardShadowColor = Colors.black.withOpacity(0.3);
  static const Color timerBackgroundColor = Colors.white;
  static const Color timerNormalColor = Colors.lightGreenAccent;
  static const Color timerWarningColor = Colors.redAccent;
  static final Color playerStatusBattingColor =
      Colors.lightGreenAccent.shade100;
  static final Color playerStatusBowlingColor = Colors.orangeAccent.shade100;
  static final Color numberButtonBg = Colors.yellow.shade700;
  static final Color numberButtonPressedBg = Colors.orange.shade600;
  static final Color numberButtonDisabledBg = Colors.grey.shade600;
  static const Color numberButtonText = Colors.black;
  static final Color numberButtonDisabledText = Colors.grey.shade400;
  static final Color overlayBackgroundColor = Colors.black;
  static final Color overlayErrorIconColor = Colors.red;
  static final Color dialogWinColor = Colors.green;
  static const Color dialogLoseColor = Colors.red;
  static final Color dialogTieColor = Colors.white;
  static final Color dialogDefaultColor = Colors.white;
  static final Color errorBackgroundColor = Colors.black;
  static final Color errorForegroundColor = Colors.red;

  // UI Opacities
  static const double numberButtonDisabledOpacity = 0.5;
  static const double timerBackgroundOpacity = 0.3;
  static const double overlayBackgroundOpacity = 0.7;
  static const double errorBackgroundOpacity = 0.5;

  // Add other constants like default volumes, API endpoints, etc. here
}
