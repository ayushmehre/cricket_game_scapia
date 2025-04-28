import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:flutter/foundation.dart';

class GameOverlayController {
  // Use ValueNotifiers for reactive state
  final ValueNotifier<double> opacity = ValueNotifier(0.0);
  final ValueNotifier<String?> imagePath = ValueNotifier(null);
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  // Keep track of the last processed overlay type to avoid redundant updates
  OverlayType _lastOverlayType = OverlayType.none;

  // Method to update overlay based on GameState
  void updateOverlayState(GameState state) {
    final currentType = state.overlayType;

    // Only update if the type has changed
    if (currentType == _lastOverlayType) return;

    _lastOverlayType = currentType;

    final newImagePath = _getImagePathForOverlay(currentType);
    final newIsVisible = currentType != OverlayType.none;
    final newOpacity = newIsVisible ? 1.0 : 0.0;

    // Update notifiers - this will trigger UI updates where listeners are attached
    imagePath.value = newImagePath;
    isVisible.value = newIsVisible;
    // Update opacity after a short delay if becoming visible,
    // or immediately if becoming invisible
    if (newIsVisible) {
      // Tiny delay allows the widget to potentially be built before fading in
      Future.delayed(const Duration(milliseconds: 50), () {
        if (_lastOverlayType == currentType) {
          // Check if state didn't change again rapidly
          opacity.value = newOpacity;
        }
      });
    } else {
      opacity.value = newOpacity;
    }
  }

  String? _getImagePathForOverlay(OverlayType type) {
    switch (type) {
      case OverlayType.battingIntro:
        return AppAssets.images.battingOverlay;
      case OverlayType.out:
        return AppAssets.images.outOverlay;
      case OverlayType.sixer:
        return AppAssets.images.sixerOverlay;
      case OverlayType.defend:
        return AppAssets.images.defendOverlay;
      case OverlayType.won:
        return AppAssets.images.wonOverlay;
      case OverlayType.lost:
        return AppAssets.images.lostOverlay;
      case OverlayType.tie:
        return AppAssets.images.tieOverlay;
      case OverlayType.none:
      default:
        return null;
    }
  }

  void dispose() {
    opacity.dispose();
    imagePath.dispose();
    isVisible.dispose();
  }
}
