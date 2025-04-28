import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._(); // Private constructor

  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue.shade900, Colors.red.shade900],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  // --- Start Playing Button ---
  static final Gradient startButtonGradient = LinearGradient(
    colors: <Color>[Colors.yellow.shade300, Colors.yellow.shade800],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static final BorderRadius startButtonRadius = BorderRadius.circular(8.0);

  static final BoxDecoration startButtonDecoration = BoxDecoration(
    gradient: startButtonGradient,
    borderRadius: startButtonRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(51),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // --- Scoreboard ---
  static const scoreboardGradient = LinearGradient(
    colors: [
      AppConstants.scoreboardGradientColor1,
      AppConstants.scoreboardGradientColor2,
      AppConstants.scoreboardGradientColor1, // Repeat for effect
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final scoreboardShadow = [
    BoxShadow(
      color: AppConstants.scoreboardShadowColor,
      spreadRadius: 2, // Keep hardcoded or make constants?
      blurRadius: 5, // Keep hardcoded or make constants?
      offset: const Offset(0, 3), // Keep hardcoded or make constants?
    ),
  ];

  static final scoreboardDecoration = BoxDecoration(
    gradient: scoreboardGradient,
    borderRadius: BorderRadius.circular(AppConstants.scoreboardBorderRadius),
    boxShadow: scoreboardShadow,
  );

  // --- Game Dialog Styles ---
  static final Color dialogBackground = Colors.brown.shade300;
  static final ShapeBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(color: Colors.brown.shade700, width: 3),
  );
  // Button style for the dialog 'Play Again' button
  static final ButtonStyle dialogButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.yellow.shade700,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    textStyle: AppTextStyles.dialogButtonText, // Link to the text style
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  // --- Shaders / Effects ---
  static final Shader goldGradientShader = LinearGradient(
    colors: <Color>[Colors.yellow.shade300, Colors.yellow.shade800],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).createShader(
    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  ); // Consider making Rect configurable
}
