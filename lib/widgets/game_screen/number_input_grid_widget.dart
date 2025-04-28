import 'package:cricket_game_scapia/utils/app_constants.dart'; // Import AppConstants
import 'package:cricket_game_scapia/utils/app_text_styles.dart'; // Import AppTextStyles
import 'package:flutter/material.dart';

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
    // Use constants for padding/spacing
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.numberGridPadding,
        vertical: 10.0,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppConstants.numberGridSpacing,
        mainAxisSpacing: AppConstants.numberGridSpacing,
        childAspectRatio: AppConstants.numberGridAspectRatio,
      ),
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        int number = index + 1;
        bool isPressed = pressedButtonNumber == number;

        // Use constants/styles
        final buttonStyle = ElevatedButton.styleFrom(
          foregroundColor:
              AppConstants.numberButtonText, // Text color for enabled
          backgroundColor:
              isEnabled
                  ? (isPressed
                      ? AppConstants.numberButtonPressedBg
                      : AppConstants.numberButtonBg)
                  : AppConstants.numberButtonDisabledBg,
          disabledForegroundColor:
              AppConstants.numberButtonDisabledText, // Text color for disabled
          disabledBackgroundColor: AppConstants.numberButtonDisabledBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // Consider making border color/width constants too if needed
            side: BorderSide(
              color: isEnabled ? Colors.brown.shade800 : Colors.grey.shade600,
              width: 2,
            ),
          ),
          elevation:
              isEnabled ? (isPressed ? 2 : 5) : 0, // Elevation logic remains
          padding: EdgeInsets.zero,
        );

        // Get text style from AppTextStyles and override color if disabled
        final baseTextStyle = AppTextStyles.numberButton;
        final textStyle =
            isEnabled
                ? baseTextStyle
                : baseTextStyle.copyWith(
                  color: AppConstants.numberButtonDisabledText,
                );

        // Apply the font family using the constant
        final finalTextStyle = textStyle.copyWith(
          fontFamily: AppTextStyles.creepsterFontFamily,
        );

        Widget child = Text('$number', style: finalTextStyle);

        // Apply disabled opacity using Opacity widget if button is disabled
        return ElevatedButton(
          onPressed: isEnabled ? () => onNumberSelected(number) : null,
          style: buttonStyle,
          child:
              isEnabled
                  ? child
                  : Opacity(
                    opacity: AppConstants.numberButtonDisabledOpacity,
                    child: child,
                  ),
        );
      },
    );
  }
}
