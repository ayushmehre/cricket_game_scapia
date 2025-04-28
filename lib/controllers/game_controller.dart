import 'dart:math'; // Import Random

import '../models/player.dart';

enum GamePhase { userBatting, botBatting, gameOver }

class GameController {
  final Player user = Player();
  final Player bot = Player();
  final Random _random = Random(); // For bot choices

  GamePhase currentPhase = GamePhase.userBatting;
  String winner = '';
  bool isTimerRunning = false;

  int currentBall = 0;
  final int totalBallsPerInning = 6; // 6 balls per inning
  int targetScore = -1; // Bot needs to score targetScore + 1 to win

  // Flags to signal UI about recent events
  bool userJustGotOut = false;
  bool botJustGotOut = false;
  bool justHitSix = false; // Flag for hitting a six

  int get userScore => user.runs;
  int get botScore => bot.runs;
  // int get ballsRemaining => totalBallsPerInning - currentBall; // Can add later if needed

  /// Generates a random number between min and max (inclusive)
  int _getRandomNumber(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }

  /// Called when the user selects a number (1-6) during their turn
  /// Or simulates user bowling during bot's turn
  void playTurn(int playerChoice) {
    if (isGameOver()) return;

    int botChoice = _getRandomNumber(1, 6);

    if (currentPhase == GamePhase.userBatting) {
      // User is batting, Bot is bowling
      _handleBattingTurn(playerChoice, botChoice);
    } else if (currentPhase == GamePhase.botBatting) {
      // Bot is batting, User is bowling (playerChoice represents user's bowl)
      _handleBowlingTurn(playerChoice, botChoice);
    }
  }

  void _handleBattingTurn(int batsmanChoice, int bowlerChoice) {
    if (batsmanChoice == bowlerChoice) {
      // User is Out
      user.markOut();
      userJustGotOut = true; // Signal user out
      _startBotInnings();
    } else {
      // User scores runs
      user.addRuns(batsmanChoice);
      if (batsmanChoice == 6) {
        justHitSix = true; // Signal six
      }
      currentBall++;
      if (currentBall >= totalBallsPerInning) {
        // Innings over (balls finished)
        _startBotInnings();
      }
    }
  }

  void _handleBowlingTurn(int bowlerChoice, int batsmanChoice) {
    if (batsmanChoice == bowlerChoice) {
      // Bot is Out
      bot.markOut();
      botJustGotOut = true; // Signal bot out
      _endGame();
    } else {
      // Bot scores runs
      bot.addRuns(batsmanChoice);
      if (batsmanChoice == 6) {
        justHitSix = true; // Signal six
      }
      currentBall++;
      if (bot.runs > targetScore) {
        // Bot reached target
        _endGame();
      } else if (currentBall >= totalBallsPerInning) {
        // Innings over (balls finished)
        _endGame();
      }
    }
  }

  /// Switch to bot's innings
  void _startBotInnings() {
    targetScore = user.runs; // Set the target for the bot
    currentBall = 0; // reset ball count for bot
    currentPhase = GamePhase.botBatting;
    // Note: GameScreen needs to know to stop showing user buttons
    // and potentially show something else, or just wait.
    // The bot's "turn" logic needs adjustment in GameScreen too.
    // For now, the controller is ready for the bot's inning.
  }

  /// End game and decide winner
  void _endGame() {
    currentPhase = GamePhase.gameOver;
    _checkWinner();
  }

  /// Decides who won based on final state
  void _checkWinner() {
    if (user.runs > bot.runs) {
      // Check if bot got out OR finished balls without reaching target
      if (bot.isOut || currentBall >= totalBallsPerInning) {
        winner = 'You Win!';
      } else {
        // Should not happen if _endGame called correctly, but defensive check
        winner = 'Error determining winner';
      }
    } else if (bot.runs > user.runs) {
      winner = 'Bot Wins!';
    } else {
      // Scores are equal
      if (currentPhase == GamePhase.gameOver) {
        // Ensure game actually ended
        winner = 'It\'s a Tie!';
      } else {
        winner = 'Error determining winner';
      }
    }
  }

  /// Called when user runs out of time
  void handleUserTimeout() {
    // If timeout happens and game isn't already over, user loses.
    if (!isGameOver()) {
      if (currentPhase == GamePhase.userBatting) {
        user.markOut(); // Mark user out if they were batting
      } else if (currentPhase == GamePhase.botBatting) {
        bot.markOut(); // Mark bot out if they were batting (game ends anyway)
      }
      winner = 'Bot Wins! (Timeout)'; // Explicitly set winner
      currentPhase = GamePhase.gameOver; // End the game immediately
    }
  }

  /// Reset everything for a new game
  void resetGame() {
    user.reset();
    bot.reset();
    currentPhase = GamePhase.userBatting;
    winner = '';
    isTimerRunning = false;
    currentBall = 0;
    targetScore = -1;
  }

  /// Clears the just-out flags (called by UI after acknowledging)
  void clearJustOutFlags() {
    userJustGotOut = false;
    botJustGotOut = false;
  }

  /// Clears the just-hit-six flag (called by UI after acknowledging)
  void clearJustHitSixFlag() {
    justHitSix = false;
  }

  // --- Helper Methods ---

  /// Check if game is over
  bool isGameOver() {
    return currentPhase == GamePhase.gameOver;
  }

  /// Check if it's user's batting turn
  bool isUserBatting() {
    return currentPhase == GamePhase.userBatting;
  }

  /// Check if it's bot's batting turn (implies user is bowling)
  bool isBotBatting() {
    return currentPhase == GamePhase.botBatting;
  }

  // Removed handleUserMove, handleBotMove, playBotTurn, endUserInnings, endBotInnings, checkWinner (integrated)
}

// Assume Player class exists in ../models/player.dart with:
// int runs = 0;
// bool isOut = false;
// void addRuns(int r) { runs += r; }
// void markOut() { isOut = true; }
// void reset() { runs = 0; isOut = false; }

// Assume getRandomNumber exists or is replaced by _getRandomNumber
// Assume delay exists or is removed (not needed here)
