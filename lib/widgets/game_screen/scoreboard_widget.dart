import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';

/// Displays the game scoreboard including scores, status, timer, and target.
class ScoreboardWidget extends StatelessWidget {
  final int userScore;
  final int botScore;
  final String userStatus;
  final String botStatus;
  final int?
  targetScore; // Nullable if no target is set (e.g., user batting first)
  final int timeLeft;
  final int currentBall;
  final int totalBallsPerInning;

  const ScoreboardWidget({
    super.key,
    required this.userScore,
    required this.botScore,
    required this.userStatus,
    required this.botStatus,
    this.targetScore,
    required this.timeLeft,
    required this.currentBall,
    required this.totalBallsPerInning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.scoreboardPadding),
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.scoreboardHorizontalMargin,
        vertical: AppConstants.scoreboardVerticalMargin,
      ),
      decoration: AppDecorations.scoreboardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ScoreDisplay(
                label: AppStrings.youLabel,
                score: userScore,
                status: userStatus,
              ),
              _TimerDisplay(timeLeft: timeLeft),
              _ScoreDisplay(
                label: AppStrings.botLabel,
                score: botScore,
                status: botStatus,
              ),
            ],
          ),
          if (targetScore != null) ...[
            const SizedBox(height: AppConstants.dialogContentSpacing),
            Text(
              '${AppStrings.targetLabel}: $targetScore',
              style: AppTextStyles.targetScore,
            ),
          ],
          const SizedBox(height: 8),
          Text(
            '${totalBallsPerInning - currentBall} balls left',
            style: AppTextStyles.playerLabel,
          ),
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
          width: AppConstants.timerWidgetSize,
          height: AppConstants.timerWidgetSize,
          child: CircularProgressIndicator(
            value: timeLeft / AppConstants.maxTimerSeconds,
            strokeWidth: AppConstants.timerStrokeWidth,
            backgroundColor: AppConstants.timerBackgroundColor.withOpacity(
              AppConstants.timerBackgroundOpacity,
            ),
            valueColor: AlwaysStoppedAnimation<Color>(
              timeLeft > AppConstants.timerWarningThreshold
                  ? AppConstants.timerNormalColor
                  : AppConstants.timerWarningColor,
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => AppDecorations.goldGradientShader,
          child: Text('$timeLeft', style: AppTextStyles.timerText),
        ),
      ],
    );
  }
}

/// Helper Widget for individual score display (You/Bot).
class _ScoreDisplay extends StatelessWidget {
  final String label;
  final int score;
  final String status;

  const _ScoreDisplay({
    required this.label,
    required this.score,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor =
        status == AppStrings.battingStatus
            ? AppConstants.playerStatusBattingColor
            : AppConstants.playerStatusBowlingColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.playerLabel),
        const SizedBox(height: AppConstants.scoreDisplaySpacingMedium),
        Text('$score', style: AppTextStyles.playerScore),
        const SizedBox(height: AppConstants.scoreDisplaySpacingSmall),
        Text(
          status,
          style: AppTextStyles.playerStatusBase.copyWith(color: statusColor),
        ),
      ],
    );
  }
}
