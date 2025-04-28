import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Manages background music and sound effects playback.
class AudioManager {
  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _isBgmPlaying = false;

  /// Initializes the audio players.
  Future<void> init() async {
    // Configure players
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.setVolume(0.5); // Set default BGM volume

    _sfxPlayer.setReleaseMode(
      ReleaseMode.stop,
    ); // Stop previous SFX before playing new

    // Pre-loading sounds can improve performance but uses more memory.
    // Example: await _sfxPlayer.audioCache.load('audio/click.mp3');
  }

  /// Plays the background music.
  ///
  /// [path] The asset path for the BGM.
  Future<void> playBgm(String path) async {
    if (_isBgmPlaying) return; // Don't restart if already playing
    try {
      await _bgmPlayer.play(AssetSource(path));
      _isBgmPlaying = true;
    } catch (e) {
      if (kDebugMode) {
        print("Error playing BGM: $e");
      }
    }
  }

  /// Stops the background music.
  Future<void> stopBgm() async {
    if (!_isBgmPlaying) return;
    try {
      await _bgmPlayer.stop();
      _isBgmPlaying = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping BGM: $e");
      }
    }
  }

  /// Plays a sound effect.
  ///
  /// [path] The asset path for the SFX.
  Future<void> playSfx(String path) async {
    try {
      // No need to stop manually if ReleaseMode.stop is set
      await _sfxPlayer.play(AssetSource(path));
    } catch (e) {
      if (kDebugMode) {
        print("Error playing SFX ($path): $e");
      }
    }
  }

  /// Releases resources used by the audio players.
  void dispose() {
    _bgmPlayer.dispose();
    _sfxPlayer.dispose();
    if (kDebugMode) {
      print("AudioManager disposed.");
    }
  }
}
