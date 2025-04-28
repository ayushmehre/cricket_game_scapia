import 'package:flutter/material.dart';

/// Central repository for reusable text styles used across the application.
class AppTextStyles {
  AppTextStyles._(); // Private constructor to prevent instantiation

  static final TextStyle statusText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.indigo.shade900,
    shadows: const [
      Shadow(blurRadius: 1, color: Colors.white, offset: Offset(1, 1)),
    ],
  );

  // --- Styles Moved from text_styles.dart ---
  static const TextStyle headingGold = TextStyle(
    fontSize: 32.0, // Increased font size
    fontWeight: FontWeight.bold,
    color: Colors.white, // Add white color for ShaderMask to work correctly
  );

  /// Style for the countdown timer text.
  static const TextStyle timerText = TextStyle(
    fontSize: 28.0, // Reduced font size for circle
    fontWeight: FontWeight.bold,
    color: Colors.white, // Needed for ShaderMask
  );

  /// Fallback style for the "How to play" heading.
  static const TextStyle howToPlayHeadingFallback = TextStyle(
    fontSize: 24, // Example size
    fontWeight: FontWeight.bold,
    color: Colors.white, // Color is overridden by ShaderMask
  );

  /// Returns the style for the main game title, incorporating the glow effect.
  /// Consider making glowValue an optional parameter if default glow is common.
  static TextStyle getGameTitleStyle(BuildContext context, double glowValue) {
    // Access theme safely
    final baseStyle = Theme.of(context).textTheme.displayMedium;
    // Default to fallback style if theme or style is null
    final effectiveStyle =
        baseStyle?.copyWith(fontFamily: 'Pacifico') ?? gameTitleFallback;

    return effectiveStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white, // Ensure color is white for shadows
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

  /// Fallback style for the main game title.
  static const TextStyle gameTitleFallback = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Pacifico',
  );

  // --- Shaders Moved from text_styles.dart ---
  // Note: Shaders might be better placed in a dedicated 'app_effects.dart' or similar
  // if more visual effects are added later.
  static final Shader goldGradientShader = LinearGradient(
    colors: <Color>[
      Colors.yellow.shade300,
      Colors.yellow.shade800,
    ], // Light gold to dark gold
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).createShader(
    const Rect.fromLTWH(
      0.0,
      0.0,
      200.0,
      70.0,
    ), // Consider making Rect configurable or dynamic
  );

  // Add other reusable text styles here
  // static const TextStyle scoreText = TextStyle(...);
  // static const TextStyle buttonText = TextStyle(...);
}
