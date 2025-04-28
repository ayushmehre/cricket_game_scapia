import 'package:audioplayers/audioplayers.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
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
    // Try getting base style from theme first
    final baseTextStyle = Theme.of(context).textTheme.labelLarge;
    final effectiveTextStyle =
        baseTextStyle?.copyWith(
          color: AppTextStyles.startButton.color,
          fontWeight: AppTextStyles.startButton.fontWeight,
        ) ??
        AppTextStyles.startButton;

    return GestureDetector(
      onTap: () {
        // TODO: Use GameAudioController via locator to play sound consistently
        _playStartSound();
        _navigateToGameScreen(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        decoration: AppDecorations.startButtonDecoration,
        child: Text(AppStrings.startPlayingButton, style: effectiveTextStyle),
      ),
    );
  }
}
