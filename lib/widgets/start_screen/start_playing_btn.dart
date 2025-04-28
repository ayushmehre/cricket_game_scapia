import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/screens/game_screen.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// A button that navigates to the GameScreen and plays a sound on tap using GameAudioController.
class StartPlayingBtn extends StatelessWidget {
  /// Creates a [StartPlayingBtn].
  const StartPlayingBtn({super.key});

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
        // Play start sound via controller
        final audioController = locator<IGameAudioController>();
        audioController.playStartGameSfx();

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
