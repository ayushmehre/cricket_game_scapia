import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart'; // Import constants
// Player is likely also in controller.dart or player.dart, remove local if duplicate
import 'package:cricket_game_scapia/models/player.dart';

// Remove local Player class if defined in imported file
/*
class Player {
  int runs = 0;
  bool isOut = false;
  void addRuns(int r) { runs += r; }
  void markOut() { isOut = true; }
  void reset() { runs = 0; isOut = false; }
}
*/

// Remove locally defined GamePhase enum
// enum GamePhase { userBatting, botBatting, gameOver }

class GameCubit extends Cubit<GameState> {
  final Player user = Player();
  final Player bot = Player();
  final Random _random;
  Timer? _countdownTimer;
  int _currentBall = 0;
  final int _totalBallsPerInning = 6; // Could be AppConstants.totalBalls

  GameCubit({Random? random})
    : _random = random ?? Random(),
      super(const GameState(currentPhase: GamePhase.userBatting));

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }

  /// Starts the game, including the initial intro overlay sequence.
  void startGame() {
    _resetGameLogic();
    emit(
      const GameState(
        currentPhase: GamePhase.userBatting,
        overlayType: OverlayType.battingIntro,
      ),
    );
    Future.delayed(AppConstants.overlayHoldDuration, () {
      if (!isClosed) {
        emit(
          state.copyWith(overlayType: OverlayType.none, buttonsEnabled: true),
        );
        _startTimer();
      }
    });
  }

  /// Resets the internal game logic state.
  void _resetGameLogic() {
    user.reset();
    bot.reset();
    _currentBall = 0;
  }

  /// Starts the 10-second countdown timer.
  void _startTimer() {
    _stopTimer();
    if (isClosed) return;
    int timeLeft = AppConstants.maxTimerSeconds; // Use constant
    emit(state.copyWith(timeLeft: timeLeft));

    _countdownTimer = Timer.periodic(AppConstants.timerTickDuration, (timer) {
      // Use constant
      if (isClosed) {
        timer.cancel();
        return;
      }
      timeLeft--;
      if (timeLeft <= 0) {
        _handleTimeout();
      } else if (!isClosed) {
        emit(state.copyWith(timeLeft: timeLeft));
      }
    });
  }

  /// Stops the countdown timer.
  void _stopTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  /// Handles the user selecting a number.
  void numberSelected(int userChoice) {
    if (state.isGameOver ||
        state.currentPhase != GamePhase.userBatting &&
            state.currentPhase != GamePhase.botBatting)
      return;

    _stopTimer();
    bool shouldTriggerAnim = state.currentPhase == GamePhase.userBatting;
    emit(
      state.copyWith(
        pressedButtonNumber: userChoice,
        buttonsEnabled: false,
        triggerThrowAnimation: shouldTriggerAnim,
      ),
    );

    Future.delayed(AppConstants.animationDelay, () {
      if (isClosed) return;
      int botChoice = _getRandomNumber(1, 6);
      _playTurn(userChoice, botChoice);

      bool enableButtonsAfterTurn =
          !state.isGameOver &&
          (state.currentPhase == GamePhase.userBatting ||
              state.currentPhase == GamePhase.botBatting);

      emit(
        state.copyWith(
          buttonsEnabled: enableButtonsAfterTurn,
          clearPressedButton: true,
          triggerThrowAnimation: false,
        ),
      );

      if (enableButtonsAfterTurn) {
        _startTimer();
      }
    });
  }

  /// Handles the logic for a single turn based on the current phase.
  void _playTurn(int playerChoice, int botChoice) {
    if (isClosed || state.isGameOver) return;
    if (state.currentPhase == GamePhase.userBatting) {
      _handleBattingTurn(playerChoice, botChoice);
    } else if (state.currentPhase == GamePhase.botBatting) {
      _handleBowlingTurn(playerChoice, botChoice);
    }
  }

  /// Logic for when the user is batting.
  void _handleBattingTurn(int userChoice, int botChoice) {
    bool isOut = userChoice == botChoice;
    bool isSix = !isOut && userChoice == 6;
    _currentBall++;
    bool inningsOver = _currentBall >= _totalBallsPerInning;

    if (isOut) {
      user.markOut();
      emit(state.copyWith(playOutSound: true));
      _showOverlayAndContinue(OverlayType.out, _startBotInnings);
    } else {
      user.addRuns(userChoice);
      emit(state.copyWith(userScore: user.runs, playSixerSound: isSix));
      if (isSix) {
        _showOverlayAndContinue(OverlayType.sixer, () {
          if (inningsOver && !state.isGameOver) _startBotInnings();
        });
      } else if (inningsOver) {
        _startBotInnings();
      }
    }
  }

  /// Logic for when the bot is batting (user is bowling).
  void _handleBowlingTurn(int userChoice, int botChoice) {
    bool isOut = userChoice == botChoice;
    bool isSix = !isOut && botChoice == 6;
    _currentBall++;
    bool inningsOver = _currentBall >= _totalBallsPerInning;

    if (isOut) {
      bot.markOut();
      emit(state.copyWith(playOutSound: true));
      _showOverlayAndContinue(OverlayType.out, _endGame);
    } else {
      bot.addRuns(botChoice);
      bool targetReached =
          state.targetScore != null && bot.runs > state.targetScore!;
      emit(state.copyWith(botScore: bot.runs, playSixerSound: isSix));

      if (isSix) {
        _showOverlayAndContinue(OverlayType.sixer, () {
          if ((targetReached || inningsOver) && !state.isGameOver) _endGame();
        });
      } else if (targetReached || inningsOver) {
        _endGame();
      }
    }
  }

  /// Handles timeout when the timer reaches zero.
  void _handleTimeout() {
    _stopTimer();
    if (isClosed || state.isGameOver) return;

    String winner;
    bool playWin = false, playLose = false;
    if (state.currentPhase == GamePhase.userBatting) {
      user.markOut();
      winner = "Bot Wins! (Timeout)";
      playLose = true;
    } else {
      bot.markOut();
      winner =
          (state.targetScore != null && state.botScore > state.targetScore!)
              ? AppStrings.youLostText
              : AppStrings.youWonText;
      if (winner == AppStrings.youWonText) {
        playWin = true;
      } else {
        playLose = true;
      }
    }

    emit(
      state.copyWith(
        isGameOver: true,
        winnerText: winner,
        currentPhase: GamePhase.gameOver,
        buttonsEnabled: false,
        overlayType: OverlayType.none,
        playWinSound: playWin,
        playLoseSound: playLose,
      ),
    );
    _endGame();
  }

  /// Switches the game phase to bot batting.
  void _startBotInnings() {
    if (isClosed || state.isGameOver) return;
    _currentBall = 0;
    emit(
      state.copyWith(
        currentPhase: GamePhase.botBatting,
        targetScore: user.runs,
        buttonsEnabled: false,
        playInningsChangeSound: true,
      ),
    );
    _showOverlayAndContinue(OverlayType.defend, () {
      if (!isClosed && !state.isGameOver) {
        emit(state.copyWith(buttonsEnabled: true));
        _startTimer();
      }
    });
  }

  /// Ends the game and determines the winner.
  void _endGame() {
    if (isClosed || state.currentPhase == GamePhase.gameOver)
      return; // Avoid multiple end game calls
    _stopTimer();
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
      ),
    );
  }

  /// Helper to show an overlay for a duration, then execute a callback.
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
          if (!isFinalOverlay) {
            emit(state.copyWith(overlayType: OverlayType.none));
          }
          onComplete();
        }
      },
    );
  }

  /// Generates a random number between min and max (inclusive).
  int _getRandomNumber(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
}
