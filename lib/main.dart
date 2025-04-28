import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator(); // Initialize the locator
  runApp(const HandCricketApp());
}

class HandCricketApp extends StatelessWidget {
  const HandCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}
