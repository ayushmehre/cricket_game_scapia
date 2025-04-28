import 'package:cricket_game_scapia/cubit/game_state.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:flutter/foundation.dart';

class OverlayState {
  final String? imagePath;
  final bool isVisible;
  final double opacity;

  const OverlayState({
    this.imagePath,
    this.isVisible = false,
    this.opacity = 0.0,
  });
}

class GameOverlayController {
  final ValueNotifier<OverlayState> overlayState = ValueNotifier(
    const OverlayState(),
  );

  void updateOverlayState(GameState state) {
    final currentType = state.overlayType;

    final newState = switch (currentType) {
      OverlayType.none => const OverlayState(),
      OverlayType.battingIntro => OverlayState(
        imagePath: AppAssets.images.battingOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.out => OverlayState(
        imagePath: AppAssets.images.outOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.sixer => OverlayState(
        imagePath: AppAssets.images.sixerOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.defend => OverlayState(
        imagePath: AppAssets.images.defendOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.won => OverlayState(
        imagePath: AppAssets.images.wonOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.lost => OverlayState(
        imagePath: AppAssets.images.lostOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
      OverlayType.tie => OverlayState(
        imagePath: AppAssets.images.tieOverlay,
        isVisible: true,
        opacity: 1.0,
      ),
    };

    overlayState.value = newState;
  }

  void hideOverlay() {
    overlayState.value = const OverlayState();
  }

  void dispose() {
    overlayState.dispose();
  }
}
