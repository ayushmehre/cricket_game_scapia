// Define Abstract Interface
abstract class IGameAudioController {
  Future<void> playStartGameSfx();
  Future<void> playClickSfx();
  Future<void> playOutSfx();
  Future<void> playSixerSfx();
  Future<void> playInningsChangeSfx();
  Future<void> playWinSfx();
  Future<void> playLoseSfx();
  Future<void> playTieSfx();
  Future<void> stopBgm();
  void dispose();
}
