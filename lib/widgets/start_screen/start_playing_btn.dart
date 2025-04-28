import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// A button that plays a sound and triggers a callback on tap.
class StartPlayingBtn extends StatelessWidget {
  /// The callback function to execute when the button is tapped.
  final VoidCallback onPressed;

  /// Creates a [StartPlayingBtn].
  const StartPlayingBtn({super.key, required this.onPressed});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _playStartSound(); // Play sound
        onPressed(); // Execute the provided callback
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
