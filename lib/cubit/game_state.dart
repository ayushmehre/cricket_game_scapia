import 'package:equatable/equatable.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';

/// Enum defining the current phase of the game.
enum GamePhase { userBatting, botBatting, gameOver }

/// Enum representing the type of overlay to display.
enum OverlayType { none, battingIntro, out, sixer, defend, won, lost, tie }

/// Represents the state of the game screen.
class GameState extends Equatable {
  final int userScore;
  final int botScore;
  final GamePhase currentPhase;
  final int timeLeft;
  final int? targetScore;
  final bool buttonsEnabled;
  final int? pressedButtonNumber;
  final bool isGameOver;
  final String? winnerText;
  final OverlayType overlayType;
  final bool playOutSound;
  final bool playSixerSound;
  final bool playInningsChangeSound;
  final bool playWinSound;
  final bool playLoseSound;
  final bool playTieSound;
  final bool triggerThrowAnimation;
  final int currentBall;
  final int totalBallsPerInning;
  final int? userChoice;
  final int? botChoice;

  const GameState({
    this.userScore = 0,
    this.botScore = 0,
    this.currentPhase = GamePhase.userBatting,
    this.timeLeft = AppConstants.maxTimerSeconds,
    this.targetScore,
    this.buttonsEnabled = false,
    this.pressedButtonNumber,
    this.isGameOver = false,
    this.winnerText,
    this.overlayType = OverlayType.none,
    this.playOutSound = false,
    this.playSixerSound = false,
    this.playInningsChangeSound = false,
    this.playWinSound = false,
    this.playLoseSound = false,
    this.playTieSound = false,
    this.triggerThrowAnimation = false,
    this.currentBall = 0,
    this.totalBallsPerInning = 6,
    this.userChoice,
    this.botChoice,
  });

  GameState copyWith({
    int? userScore,
    int? botScore,
    GamePhase? currentPhase,
    int? timeLeft,
    int? targetScore,
    bool? buttonsEnabled,
    int? pressedButtonNumber,
    bool? isGameOver,
    String? winnerText,
    OverlayType? overlayType,
    bool? playOutSound,
    bool? playSixerSound,
    bool? playInningsChangeSound,
    bool? playWinSound,
    bool? playLoseSound,
    bool? playTieSound,
    bool? triggerThrowAnimation,
    int? currentBall,
    int? totalBallsPerInning,
    bool clearPressedButton = false,
    bool clearWinnerText = false,
    int? userChoice,
    int? botChoice,
    bool clearUserChoice = false,
    bool clearBotChoice = false,
  }) {
    return GameState(
      userScore: userScore ?? this.userScore,
      botScore: botScore ?? this.botScore,
      currentPhase: currentPhase ?? this.currentPhase,
      timeLeft: timeLeft ?? this.timeLeft,
      targetScore: targetScore ?? this.targetScore,
      buttonsEnabled: buttonsEnabled ?? this.buttonsEnabled,
      pressedButtonNumber:
          clearPressedButton
              ? null
              : (pressedButtonNumber ?? this.pressedButtonNumber),
      isGameOver: isGameOver ?? this.isGameOver,
      winnerText: clearWinnerText ? null : (winnerText ?? this.winnerText),
      overlayType: overlayType ?? this.overlayType,
      playOutSound: playOutSound ?? false,
      playSixerSound: playSixerSound ?? false,
      playInningsChangeSound: playInningsChangeSound ?? false,
      playWinSound: playWinSound ?? false,
      playLoseSound: playLoseSound ?? false,
      playTieSound: playTieSound ?? false,
      triggerThrowAnimation: triggerThrowAnimation ?? false,
      currentBall: currentBall ?? this.currentBall,
      totalBallsPerInning: totalBallsPerInning ?? this.totalBallsPerInning,
      userChoice: clearUserChoice ? null : (userChoice ?? this.userChoice),
      botChoice: clearBotChoice ? null : (botChoice ?? this.botChoice),
    );
  }

  @override
  List<Object?> get props => [
    userScore,
    botScore,
    currentPhase,
    timeLeft,
    targetScore,
    buttonsEnabled,
    pressedButtonNumber,
    isGameOver,
    winnerText,
    overlayType,
    playOutSound,
    playSixerSound,
    playInningsChangeSound,
    playWinSound,
    playLoseSound,
    playTieSound,
    triggerThrowAnimation,
    currentBall,
    totalBallsPerInning,
    userChoice,
    botChoice,
  ];
}
