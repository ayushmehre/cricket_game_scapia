import 'dart:async';
import 'package:cricket_game_scapia/services/audio_manager.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:flutter/foundation.dart';

class GameAudioController {
  final AudioManager _audioManager;
  StreamSubscription? _gameStateSubscription;

  GameAudioController({required AudioManager audioManager})
    : _audioManager = audioManager {
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioManager.init();
      await _audioManager.playBgm(AppAssets.audio.bgm);
    } catch (e) {
      debugPrint("Failed to initialize or play BGM in GameAudioController: $e");
    }
  }

  Future<void> playSfx(String path) async {
    try {
      await _audioManager.playSfx(path);
    } catch (e) {
      debugPrint("Failed to play SFX in GameAudioController: $e");
    }
  }

  Future<void> stopBgm() async {
    try {
      await _audioManager.stopBgm();
    } catch (e) {
      debugPrint("Failed to stop BGM in GameAudioController: $e");
    }
  }

  void dispose() {
    _gameStateSubscription?.cancel();
    _audioManager.dispose();
  }
}
