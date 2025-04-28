import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/screens/start_screen.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
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
          backgroundColor: Colors.brown.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.brown.shade700, width: 3),
          ),
          title: Text(
            resultText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: resultColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: 'Pacifico',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${AppStrings.yourScoreLabel}: ${state.userScore}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${AppStrings.botScoreLabel}: ${state.botScore}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                AppStrings.playAgainButton,
                style: TextStyle(color: Colors.black), // Can be const
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                // Navigate back to StartScreen
                Navigator.pushAndRemoveUntil(
                  context, // Use the original context from the screen
                  MaterialPageRoute(builder: (_) => const StartScreen()),
                  (route) => false,
                );
                // onPlayAgain?.call(); // Call callback if provided
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
