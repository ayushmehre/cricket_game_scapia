/// Contains constant strings used throughout the application.
class AppStrings {
  // Prevents instantiation
  AppStrings._();

  // --- General --- //
  static const String gameTitle = 'Hand Cricket';
  static const String appTitle = 'HandCricketApp'; // Added for MaterialApp
  static const String appName = 'Cricket Game';
  static const String startGame = 'Start Game';

  // --- Start Screen --- //
  static const String howToPlay = 'How to play';
  static const String startPlayingButton = 'Start Playing';

  // --- Game Screen --- //
  static const String yourScoreLabel = 'Your Score';
  static const String botScoreLabel = 'Bot Score';
  static const String battingStatus = 'Batting';
  static const String bowlingStatus = 'Bowling';
  static const String selectNumberBattingPrompt = 'Select your number (1-6)';
  static const String selectNumberBowlingPrompt = 'Select number to bowl (1-6)';
  static const String calculatingResultPrompt = 'Calculating result...';
  static const String userRoleBatting = "You're Batting";
  static const String userRoleBowling = "You're Bowling";
  static const String turnInfoYouSelected = "You selected";
  static const String turnInfoBotSelected = "Bot selected";
  static const String outText = 'OUT!';
  static const String sixerText = 'SIXER!';
  static const String youWonText = 'You Won!';
  static const String youLostText = 'You Lost!';
  static const String itsATieText = 'It\'s a Tie!'; // Escaped apostrophe
  static const String playAgainButton = 'Play Again';
  static const String targetLabel = 'Target';
  static const String scoreLabel = 'Score';
  static const String youLabel = 'YOU';
  static const String botLabel = 'BOT';

  // Game Outcome Messages
  static const String congratulations = 'Congratulations!';
}
