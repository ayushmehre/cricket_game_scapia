import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:cricket_game_scapia/utils/app_strings.dart';
import 'package:cricket_game_scapia/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';

/// Displays the selected numbers for the user and bot during a turn transition.
class TurnInfoWidget extends StatelessWidget {
  final int? userChoice;
  final int? botChoice;

  const TurnInfoWidget({
    super.key,
    required this.userChoice,
    required this.botChoice,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 40.0;
    const double spacing = 8.0;

    final numberStyle = AppTextStyles.turnInfoText.copyWith(
      fontSize: 28,
      color: Colors.black87,
    );
    final labelStyle = AppTextStyles.turnInfoText.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    );

    // Helper to build the info box for a player
    Widget buildPlayerInfo(
      String label,
      int? choice,
      String iconPath,
      IconData fallbackIcon,
    ) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.turnInfoBoxPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.turnInfoBoxRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              height: iconSize,
              width: iconSize,
              errorBuilder:
                  (c, e, s) =>
                      Icon(fallbackIcon, size: iconSize, color: Colors.grey),
            ),
            const SizedBox(height: spacing),
            Column(
              children: [
                Text(label, style: labelStyle),
                Text('${choice ?? '...'}', style: numberStyle),
              ],
            ),
          ],
        ),
      );
    }

    return IgnorePointer(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildPlayerInfo(
              AppStrings.turnInfoYouSelected,
              userChoice,
              AppAssets.images.playerIcon,
              Icons.person,
            ),
            const SizedBox(width: spacing * 2),
            buildPlayerInfo(
              AppStrings.turnInfoBotSelected,
              botChoice,
              AppAssets.images.botIcon,
              Icons.computer,
            ),
          ],
        ),
      ),
    );
  }
}
