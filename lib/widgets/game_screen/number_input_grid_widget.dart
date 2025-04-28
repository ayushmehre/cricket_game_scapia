import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/core/game_audio_controller.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';

/// Displays the grid of number buttons (1-6) for user input.
class NumberInputGridWidget extends StatelessWidget {
  final bool isEnabled;
  final int? pressedButtonNumber;
  final Function(int) onNumberSelected;

  const NumberInputGridWidget({
    super.key,
    required this.isEnabled,
    this.pressedButtonNumber,
    required this.onNumberSelected,
  });

  @override
  Widget build(BuildContext context) {
    final IGameAudioController audioController =
        locator<IGameAudioController>();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.numberGridPadding,
        vertical: AppConstants.numberGridVerticalPadding,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.numberGridColumnCount,
        crossAxisSpacing: AppConstants.numberGridSpacing,
        mainAxisSpacing: AppConstants.numberGridSpacing,
        childAspectRatio: AppConstants.numberGridAspectRatio,
      ),
      itemCount: AppConstants.maxBattingNumber,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        int number = index + 1;
        bool isPressed = pressedButtonNumber == number;

        String imagePath = AppAssets.images.getNumberButtonPath(number);

        Widget imageWidget = Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppConstants.errorBackgroundColor.withOpacity(
                AppConstants.errorBackgroundOpacity,
              ),
              child: Center(
                child: Text('$number', style: AppTextStyles.errorText),
              ),
            );
          },
        );

        Widget sizedImageWidget = AspectRatio(
          aspectRatio: AppConstants.numberGridAspectRatio,
          child: imageWidget,
        );

        Widget finalButtonWidget =
            isPressed
                ? Transform.scale(scale: 0.9, child: sizedImageWidget)
                : sizedImageWidget;

        return GestureDetector(
          onTap:
              isEnabled
                  ? () {
                    audioController.playClickSfx();
                    onNumberSelected(number);
                  }
                  : null,
          child: finalButtonWidget,
        );
      },
    );
  }
}
