import 'package:cricket_game_scapia/cubit/game_cubit.dart';
import 'package:cricket_game_scapia/models/player.dart'; // Keep trying this path
import 'package:equatable/equatable.dart';

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

  const GameState({
    this.userScore = 0,
    this.botScore = 0,
    this.currentPhase = GamePhase.userBatting,
    this.timeLeft = 10,
    this.targetScore,
    this.buttonsEnabled = false,
    this.pressedButtonNumber,
    this.isGameOver = false,
    this.winnerText,
    this.overlayType = OverlayType.battingIntro,
    this.playOutSound = false,
    this.playSixerSound = false,
    this.playInningsChangeSound = false,
    this.playWinSound = false,
    this.playLoseSound = false,
    this.playTieSound = false,
    this.triggerThrowAnimation = false,
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
    bool clearPressedButton = false,
    bool clearWinnerText = false,
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
  ];
}
