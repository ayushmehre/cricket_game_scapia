import 'dart:async';
import 'package:cricket_game_scapia/utils/app_constants.dart';
import 'package:flutter/foundation.dart';

class TurnTimerManager {
  final VoidCallback onTimeout;
  final ValueChanged<int> onTick;
  final ValueGetter<bool> isOwnerClosed;

  Timer? _countdownTimer;

  TurnTimerManager({
    required this.onTimeout,
    required this.onTick,
    required this.isOwnerClosed,
  });

  void start() {
    stop();
    if (isOwnerClosed()) return;

    int timeLeft = AppConstants.maxTimerSeconds;
    onTick(timeLeft);

    _countdownTimer = Timer.periodic(AppConstants.timerTickDuration, (timer) {
      if (isOwnerClosed()) {
        timer.cancel();
        return;
      }

      timeLeft--;

      if (timeLeft <= 0) {
        timer.cancel();
        onTimeout();
      } else {
        onTick(timeLeft);
      }
    });
  }

  void stop() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void dispose() {
    stop();
  }
}
