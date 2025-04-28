import 'dart:async';
import 'package:cricket_game_scapia/core/audio_manager.dart';
import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:flutter/foundation.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';

// --- Removed Interface Definition ---

// --- Implement the Interface ---
class GameAudioControllerImpl implements IGameAudioController {
  final AudioManager _audioManager;

  GameAudioControllerImpl({required AudioManager audioManager})
    : _audioManager = audioManager {
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioManager.init();
      await _audioManager.playBgm(AppAssets.audio.bgm);
    } catch (e) {
      debugPrint("Error in GameAudioController _initAudio: $e");
    }
  }

  @override
  Future<void> playSfx(String path) async {
    try {
      await _audioManager.playSfx(path);
    } catch (e) {
      debugPrint("Error playing SFX in GameAudioController: $e");
    }
  }

  // --- Implement Specific SFX Methods ---
  @override
  Future<void> playStartGameSfx() => playSfx(AppAssets.audio.startGame);
  @override
  Future<void> playClickSfx() => playSfx(AppAssets.audio.click);
  @override
  Future<void> playOutSfx() => playSfx(AppAssets.audio.out);
  @override
  Future<void> playSixerSfx() => playSfx(AppAssets.audio.sixer);
  @override
  Future<void> playInningsChangeSfx() => playSfx(AppAssets.audio.inningsChange);
  @override
  Future<void> playWinSfx() => playSfx(AppAssets.audio.win);
  @override
  Future<void> playLoseSfx() => playSfx(AppAssets.audio.lose);
  @override
  Future<void> playTieSfx() => playSfx(AppAssets.audio.tie);

  @override
  Future<void> stopBgm() async {
    try {
      await _audioManager.stopBgm();
    } catch (e) {
      debugPrint("Error stopping BGM in GameAudioController: $e");
    }
  }

  @override
  void dispose() {
    _audioManager.dispose();
  }
}
