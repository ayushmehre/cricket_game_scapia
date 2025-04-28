import 'package:cricket_game_scapia/controllers/game_overlay_controller.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class FinalScoreDialogWidget extends StatelessWidget {
  final GameState state;

  const FinalScoreDialogWidget({super.key, required this.state});

  Color _getResultColor(String resultText) {
    if (resultText.startsWith(AppStrings.youWonText)) {
      return AppConstants.dialogWinColor;
    } else if (resultText.startsWith(AppStrings.youLostText)) {
      return AppConstants.dialogLoseColor;
    } else if (resultText.startsWith(AppStrings.itsATieText)) {
      return AppConstants.dialogTieColor;
    } else {
      return AppConstants.dialogDefaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String resultText = state.winnerText ?? ''; // Handle null case
    final Color resultColor = _getResultColor(resultText);

    return AlertDialog(
      backgroundColor: AppDecorations.dialogBackground,
      shape: AppDecorations.dialogShape,
      title: Text(
        resultText,
        textAlign: TextAlign.center,
        style: AppTextStyles.dialogTitleBase.copyWith(color: resultColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '${AppStrings.yourScoreLabel}: ${state.userScore}',
            style: AppTextStyles.dialogContent,
          ),
          const SizedBox(height: AppConstants.dialogContentSpacing),
          Text(
            '${AppStrings.botScoreLabel}: ${state.botScore}',
            style: AppTextStyles.dialogContent,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        ElevatedButton(
          style: AppDecorations.dialogButtonStyle,
          child: const Text(AppStrings.playAgainButton),
          onPressed: () {
            // Logic moved inside the widget's button callback
            final overlayController = locator<GameOverlayController>();
            overlayController.hideOverlay();

            Navigator.of(context).pop(); // Use context from build method
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const StartScreen()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
