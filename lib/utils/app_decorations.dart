import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue.shade900, Colors.red.shade900],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
