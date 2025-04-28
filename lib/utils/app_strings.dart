/// Contains constant strings used throughout the application.
class AppStrings {
  // Prevents instantiation
  AppStrings._();

  // --- General --- //
  static const String gameTitle = 'Hand Cricket';
  static const String appTitle = 'HandCricketApp'; // Added for MaterialApp

  // --- Start Screen --- //
  static const String howToPlay = 'How to play';
  static const String startPlayingButton = 'Start Playing';

  // --- Game Screen --- //
  static const String yourScoreLabel = 'Your Score';
  static const String botScoreLabel = 'Bot Score';
  static const String battingStatus = 'Batting';
  static const String bowlingStatus = 'Bowling';
  static const String chooseNumberPrompt = 'Choose your number (1-6)';
  static const String botChoosingPrompt = 'Bot is choosing...';
  static const String outText = 'OUT!';
  static const String sixerText = 'SIXER!';
  static const String youWonText = 'You Won!';
  static const String youLostText = 'You Lost!';
  static const String itsATieText = 'It\'s a Tie!'; // Escaped apostrophe
  static const String playAgainButton = 'Play Again';
  static const String targetLabel = 'Target';
}
