import 'package:cricket_game_scapia/utils/app_text_styles.dart'; // Import AppTextStyles
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';

/// Displays the current game status text (e.g., action prompt and user role).
class StatusTextWidget extends StatelessWidget {
  final String line1Text; // Renamed from statusText
  final String line2Text;

  const StatusTextWidget({
    super.key,
    required this.line1Text,
    required this.line2Text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.statusTextVerticalPadding,
      ), // Keep padding
      child: Column(
        // Use Column for two lines
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            line1Text,
            style: AppTextStyles.statusText, // Style for primary line
            textAlign: TextAlign.center,
          ),
          if (line2Text.isNotEmpty) ...[
            const SizedBox(height: 4), // Add spacing between lines
            Text(
              line2Text,
              style: AppTextStyles.playerRoleText, // Style for secondary line
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
