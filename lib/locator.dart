import 'package:cricket_game_scapia/controllers/game_audio_controller.dart';
import 'package:cricket_game_scapia/controllers/game_overlay_controller.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';
import 'package:cricket_game_scapia/services/audio_manager.dart';
import 'package:cricket_game_scapia/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AudioManager());
  locator.registerLazySingleton<IGameAudioController>(
    () => GameAudioControllerImpl(audioManager: locator<AudioManager>()),
  );
  locator.registerLazySingleton(() => GameOverlayController());
  locator.registerLazySingleton(() => NavigationService());
}
