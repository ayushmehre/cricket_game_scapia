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

  // Gameplay
  static const int maxTimerSeconds = 10;

  // UI Sizes (Example)
  static const double overlayImageHeightFactor = 0.4;
  static const double timerWidgetSize = 60.0;
  static const double scoreboardPadding = 16.0;
  static const double numberGridPadding = 30.0;
  static const double numberGridSpacing = 15.0;
  static const double numberGridAspectRatio = 1.5;

  // Add other constants like default volumes, API endpoints, etc. here
}
