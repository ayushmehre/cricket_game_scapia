import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Displays the animated "Hand Cricket" title with a glowing effect.
class GameTitle extends StatefulWidget {
  /// Creates a [GameTitle] widget.
  const GameTitle({super.key});

  @override
  State<GameTitle> createState() => _GameTitleState();
}

class _GameTitleState extends State<GameTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 2.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => AppDecorations.goldGradientShader,
          child: Text(
            AppStrings.gameTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.getGameTitleStyle(
              context,
              _glowAnimation.value,
            ),
          ),
        );
      },
    );
  }
}
