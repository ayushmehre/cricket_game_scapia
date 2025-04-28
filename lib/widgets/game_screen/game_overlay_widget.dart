import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';

/// Displays a semi-transparent overlay with an image, used for game events.
class GameOverlayWidget extends StatelessWidget {
  final bool isVisible;
  final double opacity;
  final String? imagePath; // Nullable if no image should be shown

  const GameOverlayWidget({
    super.key,
    required this.isVisible,
    required this.opacity,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: AppConstants.overlayFadeDuration, // Use constant
        child: Container(
          color: AppConstants
              .overlayBackgroundColor // Use constant
              .withOpacity(
                AppConstants.overlayBackgroundOpacity,
              ), // Use constant
          alignment: Alignment.center,
          child:
              imagePath != null
                  ? Image.asset(
                    imagePath!,
                    height:
                        MediaQuery.of(context).size.height *
                        AppConstants.overlayImageHeightFactor, // Use constant
                    fit: BoxFit.contain,
                    // Optional: Add errorBuilder for image loading errors
                    errorBuilder: (context, error, stackTrace) {
                      print("Error loading overlay image: $error");
                      return Icon(
                        Icons.error,
                        color:
                            AppConstants.overlayErrorIconColor, // Use constant
                        size: AppConstants.overlayErrorIconSize, // Use constant
                      );
                    },
                  )
                  : const SizedBox.shrink(), // Show nothing if imagePath is null
        ),
      ),
    );
  }
}
