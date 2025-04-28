import 'package:audioplayers/audioplayers.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// A button that navigates to the GameScreen and plays a sound on tap.
class StartPlayingBtn extends StatelessWidget {
  /// Creates a [StartPlayingBtn].
  const StartPlayingBtn({super.key});

  /// Plays the game start sound effect.
  Future<void> _playStartSound() async {
    final player = AudioPlayer();
    try {
      await player.play(AssetSource(AppAssets.audio.startGame));
    } catch (e) {
      if (kDebugMode) {
        print('Error playing start sound: $e');
      }
    }
    // Note: Disposing the player immediately might cut off the sound.
    // Consider a dedicated audio service for better management if needed.
  }

  void _navigateToGameScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _playStartSound(); // Play sound
        _navigateToGameScreen(context); // Navigate directly
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.yellow.shade300, Colors.yellow.shade800],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          AppStrings.startPlayingButton,
          style:
              Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ) ??
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
        ),
      ),
    );
  }
}
