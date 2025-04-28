import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/core/turn_manager.dart';
import 'package:cricket_game_scapia/core/turn_timer_manager.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/models/player.dart';

class GameCubit extends Cubit<GameState> {
  final Player user = Player();
  final Player bot = Player();
  final Random _random;

  late final TurnTimerManager _timerManager;
  late final TurnManager _turnManager;
  static const int _totalBallsPerInning = 6;

  GameCubit({Random? random})
    : _random = random ?? Random(),
      super(const GameState(currentPhase: GamePhase.userBatting)) {
    _timerManager = TurnTimerManager(
      onTick: _handleTimerTick,
      onTimeout: _handleTimeout,
      isOwnerClosed: () => isClosed,
    );
    _turnManager = TurnManager(totalBallsPerInning: _totalBallsPerInning);
  }

  @override
  Future<void> close() {
    _timerManager.dispose();
    return super.close();
  }

  void _handleTimerTick(int timeLeft) {
    if (!isClosed) {
      emit(state.copyWith(timeLeft: timeLeft));
    }
  }

  void startGame() {
    user.reset();
    bot.reset();
    _turnManager.resetInnings();

    emit(
      GameState(
        currentPhase: GamePhase.userBatting,
        overlayType: OverlayType.battingIntro,
        currentBall: _turnManager.currentBall,
        totalBallsPerInning: _totalBallsPerInning,
        userScore: user.runs,
        botScore: bot.runs,
      ),
    );

    Future.delayed(AppConstants.overlayHoldDuration, () {
      if (!isClosed) {
        emit(
          state.copyWith(overlayType: OverlayType.none, buttonsEnabled: true),
        );
        _timerManager.start();
      }
    });
  }

  void numberSelected(int userChoice) {
    if (state.isGameOver ||
        state.currentPhase != GamePhase.userBatting &&
            state.currentPhase != GamePhase.botBatting) {
      return;
    }

    _timerManager.stop();

    emit(
      state.copyWith(
        pressedButtonNumber: userChoice,
        buttonsEnabled: false,
        userChoice: userChoice,
        botChoice: null,
        clearBotChoice: true,
        currentBall: _turnManager.currentBall, // Show ball before it increments
      ),
    );

    Future.delayed(AppConstants.animationDelay, () async {
      if (isClosed) return;
      int botChoice = _getRandomNumber(1, 6);

      emit(state.copyWith(userChoice: userChoice, botChoice: botChoice));

      await Future.delayed(const Duration(milliseconds: 500));

      if (isClosed) return;

      _processTurn(userChoice, botChoice);
    });
  }

  void _processTurn(int userChoice, int botChoice) {
    if (isClosed || state.isGameOver) return;

    TurnResult result;
    bool playSound = false;
    OverlayType overlay = OverlayType.none;
    Function? onOverlayComplete;

    if (state.currentPhase == GamePhase.userBatting) {
      result = _turnManager.processUserTurn(userChoice, botChoice, user);
      playSound = result.isOut || result.isSix;
      overlay =
          result.isOut
              ? OverlayType.out
              : (result.isSix ? OverlayType.sixer : OverlayType.none);
      if (result.isEndOfInnings) {
        onOverlayComplete = _startBotInnings;
      }
    } else {
      // Bot Batting
      result = _turnManager.processBotTurn(
        userChoice,
        botChoice,
        bot,
        state.targetScore ?? 0,
      );
      playSound = result.isOut || result.isSix;
      overlay =
          result.isOut
              ? OverlayType.out
              : (result.isSix ? OverlayType.sixer : OverlayType.none);
      if (result.isEndOfInnings) {
        onOverlayComplete = _endGame;
      }
    }

    emit(
      state.copyWith(
        userScore: user.runs,
        botScore: bot.runs,
        playOutSound: result.isOut,
        playSixerSound: result.isSix,
        overlayType:
            OverlayType
                .none, // Reset overlay before potentially showing a new one
        clearPressedButton: true,
        currentBall: _turnManager.currentBall,
        totalBallsPerInning: _totalBallsPerInning,
        clearUserChoice: true,
        clearBotChoice: true,
      ),
    );

    // Decide next step based on turn result
    if (overlay != OverlayType.none) {
      _showOverlayAndContinue(overlay, () {
        if (onOverlayComplete != null) {
          onOverlayComplete();
        } else if (!state.isGameOver) {
          // If no specific action (innings change/game over) and game continues, enable buttons & timer
          emit(state.copyWith(buttonsEnabled: true));
          _timerManager.start();
        }
      });
    } else if (onOverlayComplete != null) {
      // Handle end of innings without an overlay (e.g., last ball wasn't out/six)
      onOverlayComplete();
    } else if (!state.isGameOver) {
      // Game continues, no overlay, no specific action -> Enable buttons & start timer
      emit(state.copyWith(buttonsEnabled: true));
      _timerManager.start();
    }
  }

  void _handleTimeout() {
    if (isClosed || state.isGameOver) return;
    _timerManager.stop(); // Ensure timer is stopped

    String winner;
    OverlayType timeoutOverlay;
    bool playLoseSound = true;

    if (state.currentPhase == GamePhase.userBatting) {
      user.markOut(); // User timed out batting -> Bot wins
      winner = "Bot Wins! (Timeout)";
      timeoutOverlay = OverlayType.lost;
    } else {
      // Bot batting (User bowling) -> User timed out bowling -> Bot wins
      winner = "Bot Wins! (Timeout)"; // Or AppStrings.youLostText?
      timeoutOverlay = OverlayType.lost;
    }

    emit(
      state.copyWith(
        isGameOver: true,
        winnerText: winner,
        currentPhase: GamePhase.gameOver,
        buttonsEnabled: false,
        overlayType: timeoutOverlay,
        playLoseSound: playLoseSound,
        userScore: user.runs, // Update scores in final state
        botScore: bot.runs,
        currentBall: _turnManager.currentBall,
        totalBallsPerInning: _totalBallsPerInning,
      ),
    );
  }

  void _startBotInnings() {
    if (isClosed || state.isGameOver) return;
    _turnManager.resetInnings();
    emit(
      state.copyWith(
        currentPhase: GamePhase.botBatting,
        targetScore: user.runs,
        buttonsEnabled: false,
        playInningsChangeSound: true,
        overlayType:
            OverlayType.none, // Ensure overlay is off before defend overlay
        currentBall: _turnManager.currentBall,
        totalBallsPerInning: _totalBallsPerInning,
        userScore: user.runs,
        botScore: bot.runs,
      ),
    );
    _showOverlayAndContinue(OverlayType.defend, () {
      if (!isClosed && !state.isGameOver) {
        emit(state.copyWith(buttonsEnabled: true));
        _timerManager.start();
      }
    });
  }

  void _endGame() {
    if (isClosed || state.currentPhase == GamePhase.gameOver) return;
    _timerManager.stop();
    String winner;
    OverlayType finalOverlay;
    bool playWin = false, playLose = false, playTie = false;

    if (user.runs > bot.runs) {
      winner = AppStrings.youWonText;
      finalOverlay = OverlayType.won;
      playWin = true;
    } else if (bot.runs > user.runs) {
      winner = AppStrings.youLostText;
      finalOverlay = OverlayType.lost;
      playLose = true;
    } else {
      winner = AppStrings.itsATieText;
      finalOverlay = OverlayType.tie;
      playTie = true;
    }

    emit(
      state.copyWith(
        isGameOver: true,
        winnerText: winner,
        currentPhase: GamePhase.gameOver,
        buttonsEnabled: false,
        overlayType: finalOverlay,
        playWinSound: playWin,
        playLoseSound: playLose,
        playTieSound: playTie,
        userScore: user.runs,
        botScore: bot.runs,
        currentBall: _turnManager.currentBall,
        totalBallsPerInning: _totalBallsPerInning,
      ),
    );
  }

  void _showOverlayAndContinue(OverlayType type, Function onComplete) {
    if (isClosed) return;
    emit(state.copyWith(overlayType: type, buttonsEnabled: false));
    Future.delayed(
      AppConstants.overlayHoldDuration + AppConstants.overlayTransitionDelay,
      () {
        if (!isClosed) {
          bool isFinalOverlay =
              type == OverlayType.won ||
              type == OverlayType.lost ||
              type == OverlayType.tie;
          // Only hide intermediate overlays
          if (!isFinalOverlay) {
            emit(state.copyWith(overlayType: OverlayType.none));
          }
          onComplete();
        }
      },
    );
  }

  int _getRandomNumber(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
}
