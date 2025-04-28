/// Contains constant asset paths organized by type.
class AppAssets {
  // Prevents instantiation
  AppAssets._();

  /// Access image asset paths.
  static const _Images images = _Images();

  /// Access audio asset paths.
  static const _Audio audio = _Audio();

  /// Access Rive asset paths and animation names.
  static const _Rive rive = _Rive();
}

/// Defines image asset paths.
class _Images {
  const _Images(); // Keep constructor const

  // Base path (optional, but can be useful)
  // static const String _base = 'assets/images';

  // Start Screen
  final String step1 = 'assets/images/step_1.png';
  final String step2 = 'assets/images/step_2.png';
  final String step3 = 'assets/images/step_3.png';

  // Game Screen Overlays
  final String battingOverlay = 'assets/images/batting.png';
  final String outOverlay = 'assets/images/game_out.png';
  final String sixerOverlay = 'assets/images/game_sixer.png';
  final String defendOverlay = 'assets/images/game_defend.png';
  final String wonOverlay = 'assets/images/you_won.png';
  final String lostOverlay = 'assets/images/you_lost.png';
  final String tieOverlay = 'assets/images/tie_game.png';

  // Game Screen UI Elements
  final String woodBoard = 'assets/images/wood_board.png';
  final String scoreBoardYou = 'assets/images/score_board_you.png';
  final String scoreBoardBot = 'assets/images/score_board_bot.png';
  final String background = 'assets/images/background.png';
}

/// Defines audio asset paths.
class _Audio {
  const _Audio(); // Keep constructor const

  // Start Screen
  final String startGame = 'audio/game_start.mp3';

  // Game Screen
  final String bgm = 'audio/game_bg_music.mp3';
  final String out = 'audio/game_out.mp3';
  final String sixer = 'audio/game_sixer.mp3';
  final String inningsChange = 'audio/game_innings_change.mp3';
  final String win = 'audio/game_win.mp3';
  final String lose = 'audio/game_lose.mp3';
  final String tie = 'audio/game_tie.mp3';
  final String click = 'audio/click.mp3';
}

/// Defines Rive asset paths and animation names.
class _Rive {
  const _Rive(); // Keep constructor const

  // Make fields final instance members, not static const
  final String character = 'assets/rive/cricket_char.riv';
  final String idleAnimation = 'Idle';
  final String throwAnimation = 'Throw';
}
