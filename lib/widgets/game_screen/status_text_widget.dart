import 'package:cricket_game_scapia/utils/app_text_styles.dart'; // Import AppTextStyles
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_constants.dart';

/// Displays the current game status text (e.g., "Choose your number", "OUT!").
class StatusTextWidget extends StatelessWidget {
  final String statusText;

  const StatusTextWidget({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.statusTextVerticalPadding,
      ),
      child: Text(
        statusText,
        style: AppTextStyles.statusText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
