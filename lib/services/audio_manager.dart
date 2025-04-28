import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Manages audio playback using the audioplayers package.
class AudioManager {
  final AudioPlayer _bgmPlayer;
  final AudioPlayer _sfxPlayer;
  Source? _currentBgmSource;

  AudioManager({AudioPlayer? bgmPlayer, AudioPlayer? sfxPlayer})
    : _bgmPlayer = bgmPlayer ?? AudioPlayer(),
      _sfxPlayer = sfxPlayer ?? AudioPlayer();

  Future<void> init() async {
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _sfxPlayer.setReleaseMode(ReleaseMode.release);
    await _bgmPlayer.setVolume(0.3);
    await _sfxPlayer.setVolume(0.8);
  }

  Future<void> playBgm(String assetPath) async {
    final source = AssetSource(assetPath);
    if (source != _currentBgmSource) {
      await _bgmPlayer.stop();
      await _bgmPlayer.play(source);
      _currentBgmSource = source;
    } else if (_bgmPlayer.state != PlayerState.playing) {
      await _bgmPlayer.resume();
    }
  }

  Future<void> stopBgm() async {
    await _bgmPlayer.stop();
    _currentBgmSource = null;
  }

  Future<void> playSfx(String assetPath) async {
    final source = AssetSource(assetPath);
    await _sfxPlayer.play(source);
  }

  void dispose() {
    _bgmPlayer.dispose();
    _sfxPlayer.dispose();
    debugPrint("AudioManager disposed.");
  }
}
