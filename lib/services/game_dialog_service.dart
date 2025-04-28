import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class GameDialogService {
  Future<void> showFinalScoreDialog(
    BuildContext context,
    GameState state,
    // Optional callback if needed when dialog is dismissed by button
    // VoidCallback? onPlayAgain,
  ) async {
    // We assume BGM stop is handled elsewhere (e.g., GameAudioController listening to state)
    if (!context.mounted || !state.isGameOver || state.winnerText == null)
      return;

    String resultText = state.winnerText!;
    Color resultColor = _getResultColor(resultText);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
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
              const SizedBox(height: 10),
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
                Navigator.of(dialogContext).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const StartScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Color _getResultColor(String resultText) {
    if (resultText.contains(AppStrings.youWonText)) {
      return Colors.green.shade700;
    } else if (resultText.contains(AppStrings.youLostText)) {
      return Colors.red.shade700;
    } else if (resultText.contains(AppStrings.itsATieText)) {
      return Colors.orange.shade700;
    } else {
      return Colors.blueGrey;
    }
  }
}
