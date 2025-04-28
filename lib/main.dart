import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/services/navigation_service.dart';
import 'package:cricket_game_scapia/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the navigation service instance
    final navigationService = locator<NavigationService>();

    return MaterialApp(
      title: 'Hand Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Assign the navigator key
      navigatorKey: navigationService.navigatorKey,
      // Define the routes
      routes: {
        AppRoutes.game: (context) => const GameScreen(),
        // Assuming StartScreen is the initial route
        // AppRoutes.home: (context) => const StartScreen(),
      },
      // Set the initial route
      // initialRoute: AppRoutes.home,
      home: const StartScreen(), // Start with StartScreen for now
    );
  }
}
