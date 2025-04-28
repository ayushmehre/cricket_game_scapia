import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';

/// Displays the animated "Hand Cricket" title with a glowing effect.
class GameTitle extends StatefulWidget {
  /// Creates a [GameTitle] widget.
  const GameTitle({super.key});

  @override
  State<GameTitle> createState() => _GameTitleState();
}

class _GameTitleState extends State<GameTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 5.0, end: 15.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation, // Use the state's animation
      builder: (context, child) {
        // Get the dynamic style from AppTextStyles
        final titleStyle = AppTextStyles.getGameTitleStyle(
          context,
          _glowAnimation.value,
        );

        return Text(
          AppStrings.gameTitle,
          textAlign: TextAlign.center,
          style: titleStyle,
        );
      },
    );
  }
}
