import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/services/navigation_service.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const HandCricketApp());
}

class HandCricketApp extends StatelessWidget {
  const HandCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      navigatorKey: navigationService.navigatorKey,
      routes: {AppRoutes.game: (context) => const GameScreen()},
      home: const StartScreen(),
    );
  }
}
