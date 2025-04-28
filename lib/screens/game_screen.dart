import 'dart:async';
import 'package:cricket_game_scapia/core/game_overlay_controller.dart'
    as controller;
import 'package:cricket_game_scapia/cubit/game_cubit.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_strings.dart';
import '../utils/app_assets.dart';
import '../widgets/game_screen/scoreboard_widget.dart';
import '../widgets/game_screen/status_text_widget.dart';
import '../widgets/game_screen/number_input_grid_widget.dart';
import '../widgets/game_screen/game_overlay_widget.dart';
import '../widgets/game_screen/turn_info_widget.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';
import '../widgets/dialogs/final_score_dialog_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..startGame(),
      child: const _GameView(),
    );
  }
}

class _GameView extends StatefulWidget {
  const _GameView();

  @override
  State<_GameView> createState() => _GameViewState();
}

class _GameViewState extends State<_GameView> {
  final IGameAudioController _audioController = locator<IGameAudioController>();
  final controller.GameOverlayController _overlayController =
      locator<controller.GameOverlayController>();

  StreamSubscription? _gameStateSubscription;

  @override
  void initState() {
    super.initState();
    final gameCubit = context.read<GameCubit>();
    _listenToGameState(gameCubit.stream);
  }

  void _listenToGameState(Stream<GameState> stream) {
    _gameStateSubscription = stream.listen(
      (state) {
        if (state.playOutSound) _audioController.playOutSfx();
        if (state.playSixerSound) _audioController.playSixerSfx();
        if (state.playInningsChangeSound) {
          _audioController.playInningsChangeSfx();
        }
        if (state.playWinSound) _audioController.playWinSfx();
        if (state.playLoseSound) _audioController.playLoseSfx();
        if (state.playTieSound) _audioController.playTieSfx();

        if (state.isGameOver) {
          _audioController.stopBgm();
        }

        _overlayController.updateOverlayState(state);

        if (state.isGameOver && state.winnerText != null) {
          final totalDelay =
              AppConstants.resultOverlayHoldDuration +
              AppConstants.dialogShowDelay;
          Future.delayed(totalDelay, () {
            if (mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => FinalScoreDialogWidget(state: state),
              );
            }
          });
        }
      },
      onError: (error) {
        debugPrint("Error listening to GameState: $error");
      },
    );
  }

  @override
  void dispose() {
    _gameStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        String line1Text;
        String line2Text;

        if (state.isGameOver) {
          line1Text = state.winnerText ?? '';
          line2Text = '';
        } else if (state.buttonsEnabled) {
          if (state.currentPhase == GamePhase.userBatting) {
            line1Text = AppStrings.selectNumberBattingPrompt;
            line2Text = AppStrings.userRoleBatting;
          } else {
            line1Text = AppStrings.selectNumberBowlingPrompt;
            line2Text = AppStrings.userRoleBowling;
          }
        } else {
          line1Text = AppStrings.calculatingResultPrompt;
          if (state.currentPhase == GamePhase.userBatting) {
            line2Text = AppStrings.userRoleBatting;
          } else {
            line2Text = AppStrings.userRoleBowling;
          }
        }

        bool isUserBattingPhase = state.currentPhase == GamePhase.userBatting;
        String userStatus =
            isUserBattingPhase
                ? AppStrings.battingStatus
                : AppStrings.bowlingStatus;
        String botStatus =
            state.currentPhase == GamePhase.botBatting
                ? AppStrings.battingStatus
                : AppStrings.bowlingStatus;
        int? targetScore =
            state.currentPhase == GamePhase.botBatting
                ? state.targetScore
                : null;

        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AppAssets.images.background,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: AppConstants.errorBackgroundColor,
                      child: Center(
                        child: Text(
                          'Error loading background',
                          style: AppTextStyles.errorText,
                        ),
                      ),
                    ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    ScoreboardWidget(
                      userScore: state.userScore,
                      botScore: state.botScore,
                      userStatus: userStatus,
                      botStatus: botStatus,
                      targetScore: targetScore,
                      timeLeft: state.timeLeft,
                      currentBall: state.currentBall,
                      totalBallsPerInning: state.totalBallsPerInning,
                    ),
                    Expanded(
                      flex: 2,
                      child: TurnInfoWidget(
                        userChoice: state.userChoice,
                        botChoice: state.botChoice,
                      ),
                    ),
                    StatusTextWidget(
                      line1Text: line1Text,
                      line2Text: line2Text,
                    ),
                    Expanded(
                      flex: 1,
                      child: NumberInputGridWidget(
                        isEnabled: state.buttonsEnabled,
                        pressedButtonNumber: state.pressedButtonNumber,
                        onNumberSelected:
                            (number) => context
                                .read<GameCubit>()
                                .numberSelected(number),
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<controller.OverlayState>(
                valueListenable: _overlayController.overlayState,
                builder: (_, overlay, __) {
                  return GameOverlayWidget(
                    isVisible: overlay.isVisible,
                    opacity: overlay.opacity,
                    imagePath: overlay.imagePath,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
