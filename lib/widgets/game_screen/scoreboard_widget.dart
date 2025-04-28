import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Displays the game scoreboard including scores, status, timer, and target.
class ScoreboardWidget extends StatelessWidget {
  final int userScore;
  final int botScore;
  final String userStatus;
  final String botStatus;
  final int?
  targetScore; // Nullable if no target is set (e.g., user batting first)
  final int timeLeft;

  const ScoreboardWidget({
    super.key,
    required this.userScore,
    required this.botScore,
    required this.userStatus,
    required this.botStatus,
    this.targetScore,
    required this.timeLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.images.woodBoard),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ScoreDisplay(
                labelImagePath: AppAssets.images.scoreBoardYou,
                score: userScore,
                status: userStatus,
              ),
              _TimerDisplay(timeLeft: timeLeft), // Use extracted timer widget
              _ScoreDisplay(
                labelImagePath: AppAssets.images.scoreBoardBot,
                score: botScore,
                status: botStatus,
              ),
            ],
          ),
          // Display Target if available
          if (targetScore != null) ...[
            const SizedBox(height: 10),
            Text(
              '${AppStrings.targetLabel}: $targetScore',
              style: AppTextStyles.targetScore, // Use defined style
            ),
          ],
        ],
      ),
    );
  }
}

/// Displays the countdown timer with a circular progress indicator.
class _TimerDisplay extends StatelessWidget {
  final int timeLeft;

  const _TimerDisplay({required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: timeLeft / 10.0, // Assuming 10 seconds max
            strokeWidth: 5,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              timeLeft > 3 ? Colors.lightGreenAccent : Colors.redAccent,
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => AppTextStyles.goldGradientShader,
          child: Text('$timeLeft', style: AppTextStyles.timerText),
        ),
      ],
    );
  }
}

/// Helper Widget for individual score display (You/Bot).
class _ScoreDisplay extends StatelessWidget {
  final String labelImagePath;
  final int score;
  final String status;

  const _ScoreDisplay({
    required this.labelImagePath,
    required this.score,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on status
    final statusColor =
        status == AppStrings.battingStatus
            ? Colors.lightGreenAccent.shade100
            : Colors.orangeAccent.shade100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(labelImagePath, height: 30),
        const SizedBox(height: 8),
        Text(
          '$score',
          style: AppTextStyles.playerScore, // Use defined style
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: AppTextStyles.playerStatusBase.copyWith(
            color: statusColor,
          ), // Use base style + color
        ),
      ],
    );
  }
}
