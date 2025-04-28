import 'package:cricket_game_scapia/utils/app_text_styles.dart'; // Import AppTextStyles
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
  // static final EdgeInsets startButtonPadding = const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0);
  // static final List<BoxShadow> startButtonShadow = [
  //   BoxShadow(
  //     color: Colors.black.withOpacity(0.2),
  //     spreadRadius: 1,
  //     blurRadius: 4,
  //     offset: const Offset(0, 2),
  //   ),
  // ];

  // Combine into a full decoration:
  static final BoxDecoration startButtonDecoration = BoxDecoration(
    gradient: startButtonGradient,
    borderRadius: startButtonRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
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
