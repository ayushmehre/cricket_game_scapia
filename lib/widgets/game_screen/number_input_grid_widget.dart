import 'package:cricket_game_scapia/utils/app_constants.dart'; // Import AppConstants
import 'package:cricket_game_scapia/utils/app_text_styles.dart'; // Import AppTextStyles
import 'package:flutter/material.dart';

// Added imports
import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/locator.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// Displays the grid of number buttons (1-6) for user input.
class NumberInputGridWidget extends StatelessWidget {
  final bool isEnabled;
  final int? pressedButtonNumber; // Track which button is visually pressed
  final Function(int) onNumberSelected;

  const NumberInputGridWidget({
    super.key,
    required this.isEnabled,
    this.pressedButtonNumber,
    required this.onNumberSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Get the audio controller instance
    final GameAudioController audioController = locator<GameAudioController>();

    // Use constants for padding/spacing
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
        // Determine if this specific button is the one visually pressed
        bool isPressed = pressedButtonNumber == number;

        // Get the appropriate image path
        String imagePath = AppAssets.images.getNumberButtonPath(
          number,
          isPressed,
        );

        Widget imageWidget = Image.asset(
          imagePath,
          fit: BoxFit.contain, // Adjust fit as needed
          // Add error builder for robustness
          errorBuilder: (context, error, stackTrace) {
            // Fallback widget if image fails to load
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

        // Wrap with AspectRatio to maintain size
        Widget sizedImageWidget = AspectRatio(
          aspectRatio: AppConstants.numberGridAspectRatio,
          child: imageWidget,
        );

        // Wrap with Opacity if disabled
        // Widget buttonContent =
        //     isEnabled
        //         ? sizedImageWidget
        //         : Opacity(
        //             opacity: AppConstants.numberButtonDisabledOpacity,
        //             child: sizedImageWidget,
        //           );

        // Use GestureDetector for interaction
        return GestureDetector(
          onTap:
              isEnabled
                  ? () {
                    audioController.playSfx(AppAssets.audio.click);
                    onNumberSelected(number);
                  }
                  : null,
          // child: buttonContent, // Old logic
          child: sizedImageWidget, // Always show the sized image directly
        );
      },
    );
  }
}
