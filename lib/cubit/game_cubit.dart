import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/models/player.dart';

class GameCubit extends Cubit<GameState> {
  final Player user = Player();
  final Player bot = Player();
  final Random _random;
  Timer? _countdownTimer;
  int _currentBall = 0;
  final int _totalBallsPerInning = 6;

  GameCubit({Random? random})
    : _random = random ?? Random(),
      super(const GameState(currentPhase: GamePhase.userBatting));

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }

  void startGame() {
    _resetGameLogic();
    emit(
      GameState(
        currentPhase: GamePhase.userBatting,
        overlayType: OverlayType.battingIntro,
        currentBall: _currentBall,
        totalBallsPerInning: _totalBallsPerInning,
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

  void _resetGameLogic() {
    user.reset();
    bot.reset();
    _currentBall = 0;
  }

  void _startTimer() {
    _stopTimer();
    if (isClosed) return;
    int timeLeft = AppConstants.maxTimerSeconds;
    emit(state.copyWith(timeLeft: timeLeft));

    _countdownTimer = Timer.periodic(AppConstants.timerTickDuration, (timer) {
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

  void _stopTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

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
        currentBall: _currentBall,
        totalBallsPerInning: _totalBallsPerInning,
        userChoice: userChoice,
        botChoice: null,
        clearBotChoice: true,
      ),
    );

    Future.delayed(AppConstants.animationDelay, () async {
      if (isClosed) return;
      int botChoice = _getRandomNumber(1, 6);

      emit(state.copyWith(userChoice: userChoice, botChoice: botChoice));

      await Future.delayed(const Duration(milliseconds: 500));

      if (isClosed) return;

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
          currentBall: _currentBall,
          totalBallsPerInning: _totalBallsPerInning,
          clearUserChoice: true,
          clearBotChoice: true,
        ),
      );

      if (enableButtonsAfterTurn) {
        _startTimer();
      }
    });
  }

  void _playTurn(int playerChoice, int botChoice) {
    if (isClosed || state.isGameOver) return;
    if (state.currentPhase == GamePhase.userBatting) {
      _handleBattingTurn(playerChoice, botChoice);
    } else if (state.currentPhase == GamePhase.botBatting) {
      _handleBowlingTurn(playerChoice, botChoice);
    }
  }

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
      emit(
        state.copyWith(
          userScore: user.runs,
          playSixerSound: isSix,
          overlayType: OverlayType.none,
          currentBall: _currentBall,
          totalBallsPerInning: _totalBallsPerInning,
        ),
      );
      if (isSix) {
        _showOverlayAndContinue(OverlayType.sixer, () {
          if (inningsOver && !state.isGameOver) _startBotInnings();
        });
      } else if (inningsOver) {
        _startBotInnings();
      }
    }
  }

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
      emit(
        state.copyWith(
          botScore: bot.runs,
          playSixerSound: isSix,
          overlayType: OverlayType.none,
          currentBall: _currentBall,
          totalBallsPerInning: _totalBallsPerInning,
        ),
      );

      if (isSix) {
        _showOverlayAndContinue(OverlayType.sixer, () {
          if ((targetReached || inningsOver) && !state.isGameOver) _endGame();
        });
      } else if (targetReached || inningsOver) {
        _endGame();
      }
    }
  }

  void _handleTimeout() {
    _stopTimer();
    if (isClosed || state.isGameOver) return;

    String winner;
    bool playWin = false, playLose = false;
    OverlayType timeoutOverlay = OverlayType.none;

    if (state.currentPhase == GamePhase.userBatting) {
      user.markOut();
      winner = "Bot Wins! (Timeout)";
      playLose = true;
      timeoutOverlay = OverlayType.lost;
    } else {
      winner = "${AppStrings.youLostText} (Timeout)";
      playWin = false;
      playLose = true;
      timeoutOverlay = OverlayType.lost;
    }

    emit(
      state.copyWith(
        isGameOver: true,
        winnerText: winner,
        currentPhase: GamePhase.gameOver,
        buttonsEnabled: false,
        overlayType: timeoutOverlay,
        playWinSound: playWin,
        playLoseSound: playLose,
        currentBall: _currentBall,
        totalBallsPerInning: _totalBallsPerInning,
      ),
    );
  }

  void _startBotInnings() {
    if (isClosed || state.isGameOver) return;
    _currentBall = 0;
    emit(
      state.copyWith(
        currentPhase: GamePhase.botBatting,
        targetScore: user.runs,
        buttonsEnabled: false,
        playInningsChangeSound: true,
        currentBall: _currentBall,
        totalBallsPerInning: _totalBallsPerInning,
      ),
    );
    _showOverlayAndContinue(OverlayType.defend, () {
      if (!isClosed && !state.isGameOver) {
        emit(state.copyWith(buttonsEnabled: true));
        _startTimer();
      }
    });
  }

  void _endGame() {
    if (isClosed || state.currentPhase == GamePhase.gameOver) return;
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
        currentBall: _currentBall,
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
