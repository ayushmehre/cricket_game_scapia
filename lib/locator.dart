import 'package:cricket_game_scapia/core/game_audio_controller.dart';
import 'package:cricket_game_scapia/core/game_overlay_controller.dart';
import 'package:cricket_game_scapia/interfaces/i_game_audio_controller.dart';
import 'package:cricket_game_scapia/core/audio_manager.dart';
import 'package:cricket_game_scapia/core/navigation_service.dart';
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
