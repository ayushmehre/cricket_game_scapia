import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/controllers/game_overlay_controller.dart';
import 'package:cricket_game_scapia/services/audio_manager.dart';
import 'package:cricket_game_scapia/services/game_dialog_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => AudioManager());
  locator.registerLazySingleton(() => GameDialogService());

  // Controllers (depend on other services)
  locator.registerLazySingleton(
    () => GameAudioController(audioManager: locator<AudioManager>()),
  );
  locator.registerLazySingleton(() => GameOverlayController());

  // You might register Cubits/Blocs here too if needed globally,
  // but often they are provided closer to the UI tree (like in GameScreen).
}
