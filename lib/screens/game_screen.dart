import 'dart:async';
import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/controllers/game_overlay_controller.dart';
import 'package:cricket_game_scapia/cubit/game_cubit.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/services/game_dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_strings.dart';
import '../utils/app_assets.dart';
import 'package:cricket_game_scapia/controllers/game_controller.dart'
    show GamePhase;
import '../widgets/game_screen/scoreboard_widget.dart';
import '../widgets/game_screen/status_text_widget.dart';
import '../widgets/game_screen/number_input_grid_widget.dart';
import '../widgets/game_screen/game_overlay_widget.dart';
import '../widgets/game_screen/character_animation_widget.dart';

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
  final GameAudioController _audioController = locator<GameAudioController>();
  final GameOverlayController _overlayController =
      locator<GameOverlayController>();
  final GameDialogService _dialogService = locator<GameDialogService>();

  final GlobalKey<CharacterAnimationWidgetState> _characterAnimKey =
      GlobalKey();

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
        if (state.playOutSound) _audioController.playSfx(AppAssets.audio.out);
        if (state.playSixerSound)
          _audioController.playSfx(AppAssets.audio.sixer);
        if (state.playInningsChangeSound)
          _audioController.playSfx(AppAssets.audio.inningsChange);
        if (state.playWinSound) _audioController.playSfx(AppAssets.audio.win);
        if (state.playLoseSound) _audioController.playSfx(AppAssets.audio.lose);
        if (state.playTieSound) _audioController.playSfx(AppAssets.audio.tie);

        if (state.isGameOver) {
          _audioController.stopBgm();
        }

        _overlayController.updateOverlayState(state);

        if (state.triggerThrowAnimation) {
          _characterAnimKey.currentState?.playThrow();
        }

        if (state.isGameOver && state.winnerText != null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _dialogService.showFinalScoreDialog(context, state);
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
    _audioController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        bool isUserBattingPhase = state.currentPhase == GamePhase.userBatting;
        String statusText =
            isUserBattingPhase
                ? AppStrings.chooseNumberPrompt
                : AppStrings.botChoosingPrompt;

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
                      color: Colors.black,
                      child: const Center(
                        child: Text(
                          'Error loading background',
                          style: TextStyle(color: Colors.red),
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
                    ),
                    Expanded(
                      flex: 2,
                      child: CharacterAnimationWidget(key: _characterAnimKey),
                    ),
                    StatusTextWidget(statusText: statusText),
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
              ValueListenableBuilder<bool>(
                valueListenable: _overlayController.isVisible,
                builder: (_, isVisible, __) {
                  return ValueListenableBuilder<double>(
                    valueListenable: _overlayController.opacity,
                    builder: (_, opacity, __) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: _overlayController.imagePath,
                        builder: (_, imagePath, __) {
                          return GameOverlayWidget(
                            isVisible: isVisible,
                            opacity: opacity,
                            imagePath: imagePath,
                          );
                        },
                      );
                    },
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
