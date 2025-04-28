import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/services/navigation_service.dart';
import 'package:cricket_game_scapia/utils/routes.dart';

/// A button that navigates to the GameScreen and plays a sound on tap using GameAudioController.
class StartPlayingBtn extends StatelessWidget {
  /// Creates a [StartPlayingBtn].
  const StartPlayingBtn({super.key});

  void _navigateToGameScreen() {
    final navigationService = locator<NavigationService>();
    navigationService.navigateTo(AppRoutes.game);
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

        _navigateToGameScreen();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        decoration: AppDecorations.startButtonDecoration,
        child: Text(AppStrings.startPlayingButton, style: effectiveTextStyle),
      ),
    );
  }
}
