/// Contains constant asset paths organized by type.
class AppAssets {
  // Prevents instantiation
  AppAssets._();

  /// Access image asset paths.
  static const _Images images = _Images();

  /// Access audio asset paths.
  static const _Audio audio = _Audio();
}

/// Defines image asset paths.
class _Images {
  const _Images(); // Keep constructor const

  // --- Start Screen ---
  final String step1 = 'assets/images/step_1.png';
  final String step2 = 'assets/images/step_2.png';
  final String step3 = 'assets/images/step_3.png';

  // --- Game Screen Overlays ---
  final String battingOverlay = 'assets/images/batting.png';
  final String outOverlay = 'assets/images/out.png';
  final String sixerOverlay = 'assets/images/sixer.png';
  final String defendOverlay = 'assets/images/game_defend.png';
  final String wonOverlay = 'assets/images/you_won.png';
  final String lostOverlay = 'assets/images/you_lost.png';
  final String tieOverlay = 'assets/images/its_a_tie.png';

  // --- Game Screen UI Elements ---
  final String background = 'assets/images/background.png';
  final String playerIcon = 'assets/images/player_icon.png';
  final String botIcon = 'assets/images/bot_icon.png';

  // --- Number Buttons ---
  String getNumberButtonPath(int number) {
    switch (number) {
      case 1:
        return 'assets/images/one.png';
      case 2:
        return 'assets/images/two.png';
      case 3:
        return 'assets/images/three.png';
      case 4:
        return 'assets/images/four.png';
      case 5:
        return 'assets/images/five.png';
      case 6:
        return 'assets/images/six.png';
      default:
        return 'assets/images/one.png'; // Fallback
    }
  }
}

/// Defines audio asset paths.
class _Audio {
  const _Audio(); // Keep constructor const

  // --- Start Screen ---
  final String startGame = 'audio/game_start.mp3';

  // --- Game Screen ---
  final String bgm = 'audio/game_bg_music.mp3';
  final String out = 'audio/game_out.mp3';
  final String sixer = 'audio/game_sixer.mp3';
  final String inningsChange = 'audio/game_innings_change.mp3';
  final String win = 'audio/game_win.mp3';
  final String lose = 'audio/game_lose.mp3';
  final String tie = 'audio/game_tie.mp3';
  final String click = 'audio/beep.mp3';
}
