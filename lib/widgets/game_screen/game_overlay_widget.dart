import 'package:flutter/material.dart';

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
        duration: const Duration(milliseconds: 300), // Standard fade duration
        child: Container(
          color: Colors.black.withOpacity(0.7), // Standard background
          alignment: Alignment.center,
          child:
              imagePath != null
                  ? Image.asset(
                    imagePath!,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.contain,
                    // Optional: Add errorBuilder for image loading errors
                    errorBuilder: (context, error, stackTrace) {
                      print("Error loading overlay image: $error");
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 60,
                      );
                    },
                  )
                  : const SizedBox.shrink(), // Show nothing if imagePath is null
        ),
      ),
    );
  }
}
