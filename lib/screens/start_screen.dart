import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/widgets/start_screen/game_title.dart';
import 'package:cricket_game_scapia/widgets/start_screen/how_to_play_section.dart';
import 'package:cricket_game_scapia/widgets/start_screen/start_playing_btn.dart';

/// The initial screen displayed when the game starts.
///
/// Shows the game title, instructions on how to play, and a button
/// to navigate to the main game screen.
class StartScreen extends StatefulWidget {
  /// Creates a [StartScreen].
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: AppDecorations.backgroundGradient),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const GameTitle(),
                  const SizedBox(height: 40),
                  // How to Play Instructions
                  const HowToPlaySection(),
                  const SizedBox(height: 40),
                  // Start Playing Button
                  const StartPlayingBtn(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
