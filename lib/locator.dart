import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/controllers/game_overlay_controller.dart';
import 'package:cricket_game_scapia/services/audio_manager.dart';
import 'package:cricket_game_scapia/services/game_dialog_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AudioManager());
  locator.registerLazySingleton(() => GameDialogService());
  locator.registerLazySingleton(
    () => GameAudioController(audioManager: locator<AudioManager>()),
  );
  locator.registerLazySingleton(() => GameOverlayController());
}
