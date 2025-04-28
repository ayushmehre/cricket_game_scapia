import 'package:cricket_game_scapia/models/player.dart';

class TurnResult {
  final int runsScored;
  final bool isOut;
  final bool isSix;
  final bool isEndOfInnings;
  final bool targetReached;

  TurnResult({
    this.runsScored = 0,
    this.isOut = false,
    this.isSix = false,
    this.isEndOfInnings = false,
    this.targetReached = false,
  });
}

class TurnManager {
  final int _totalBallsPerInning;
  int _currentBall = 0;

  TurnManager({required int totalBallsPerInning})
    : _totalBallsPerInning = totalBallsPerInning;

  void resetInnings() {
    _currentBall = 0;
  }

  int get currentBall => _currentBall;

  TurnResult processUserTurn(int userChoice, int botChoice, Player user) {
    _currentBall++;
    bool isOut = userChoice == botChoice;
    bool isSix = !isOut && userChoice == 6;
    bool isEndOfInnings = _currentBall >= _totalBallsPerInning;
    int runs = isOut ? 0 : userChoice;

    if (isOut) {
      user.markOut();
    } else {
      user.addRuns(runs);
    }

    return TurnResult(
      runsScored: runs,
      isOut: isOut,
      isSix: isSix,
      isEndOfInnings: isEndOfInnings || isOut,
    );
  }

  TurnResult processBotTurn(
    int userChoice,
    int botChoice,
    Player bot,
    int targetScore,
  ) {
    _currentBall++;
    bool isOut = userChoice == botChoice;
    bool isSix = !isOut && botChoice == 6;
    bool isEndOfInnings = _currentBall >= _totalBallsPerInning;
    int runs = isOut ? 0 : botChoice;

    if (isOut) {
      bot.markOut();
    } else {
      bot.addRuns(runs);
    }

    bool targetReached = bot.runs > targetScore;

    return TurnResult(
      runsScored: runs,
      isOut: isOut,
      isSix: isSix,
      isEndOfInnings: isEndOfInnings || isOut || targetReached,
      targetReached: targetReached,
    );
  }
}
