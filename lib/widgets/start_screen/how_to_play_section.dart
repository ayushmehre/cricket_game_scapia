import 'package:cricket_game_scapia/utils/app_decorations.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// Displays the "How to play" instructions with images.
class HowToPlaySection extends StatelessWidget {
  /// Creates a [HowToPlaySection] widget.
  const HowToPlaySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Consistent padding for the section
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);
    // Consistent corner radius for images
    final imageBorderRadius = BorderRadius.circular(
      12.0,
    ); // Slightly larger radius

    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppDecorations.goldGradientShader,
          child: Text(
            AppStrings.howToPlay,
            // Use headingGold or the new fallback style
            style: AppTextStyles.headingGold,
          ),
        ),
        const SizedBox(height: 30), // Adjusted spacing
        Padding(
          padding: horizontalPadding,
          child: ClipRRect(
            borderRadius: imageBorderRadius,
            child: Image.asset(AppAssets.images.step1),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: horizontalPadding,
          child: ClipRRect(
            borderRadius: imageBorderRadius,
            child: Image.asset(AppAssets.images.step2),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: horizontalPadding,
          child: ClipRRect(
            borderRadius: imageBorderRadius,
            child: Image.asset(AppAssets.images.step3),
          ),
        ),
      ],
    );
  }
}
