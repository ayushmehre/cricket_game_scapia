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
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 1.5,
      ),
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        int number = index + 1;
        bool isPressed = pressedButtonNumber == number;

        // Define button style here or fetch from Theme/AppStyles
        final buttonStyle = ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor:
              isPressed ? Colors.yellow.shade800 : Colors.yellow.shade600,
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isEnabled ? Colors.brown.shade800 : Colors.grey.shade600,
              width: 2,
            ),
          ),
          elevation: isEnabled ? (isPressed ? 2 : 5) : 0,
          padding: EdgeInsets.zero,
        );

        // Define text style here or fetch from Theme/AppStyles
        final textStyle = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'Creepster', // Consider adding to AppTextStyles or Theme
          color: isEnabled ? Colors.black : Colors.black54,
        );

        return ElevatedButton(
          onPressed: isEnabled ? () => onNumberSelected(number) : null,
          style: buttonStyle,
          child: Text('$number', style: textStyle),
        );
      },
    );
  }
}
