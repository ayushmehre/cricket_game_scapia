# Hand Cricket Game (Scapia Assignment)

A simple implementation of the Hand Cricket game built with Flutter.

## Overview

This project demonstrates a basic Hand Cricket game where the user plays against a bot. The game involves choosing numbers (1-6) simultaneously. If the numbers match, the batsman is out. Otherwise, the batsman scores the runs they chose.

## Features

- Simple Hand Cricket gameplay (User bats first, then bowls).
- Score tracking for user and bot.
- Turn-based timer (10 seconds per choice).
- Visual feedback using Rive animations (character throw).
- Sound effects for game events (six, out, win, lose, etc.) and background music.
- Clear UI displaying scores, player status, target score, and timer.
- Game result overlays (Win, Lose, Tie, Out, Sixer).

## Architecture & Libraries Used

- **State Management:** `flutter_bloc` / `cubit` (`GameCubit`) for managing the core game logic and state (`GameState`).
- **Dependency Injection:** `get_it` is used to manage dependencies like controllers and services.
- **Audio:** `audioplayers` for background music and sound effects, managed via `GameAudioController` and `AudioManager` service.
- **Animation:** `rive` for character animations.
- **UI Structure:** Separated UI components (widgets) for better organization (e.g., `ScoreboardWidget`, `NumberInputGridWidget`, `CharacterAnimationWidget`).
- **Controllers/Services:** Logic for UI concerns like audio (`GameAudioController`), overlays (`GameOverlayController`), and dialogs (`GameDialogService`) are extracted from the main view state.
- **Code Style:** Follows standard Flutter linting rules.
- **Assets & Styles:** Centralized management of strings (`AppStrings`), assets (`AppAssets`), and text styles (`AppTextStyles`).

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd cricket_game_scapia
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

## Project Structure (Key Directories)

- `lib/`: Main application code.
  - `cubit/`: Contains the `GameCubit` and `GameState`.
  - `screens/`: UI screens (`start_screen.dart`, `game_screen.dart`).
  - `widgets/`: Reusable UI components, categorized by screen.
  - `controllers/`: UI-specific controllers (`GameAudioController`, `GameOverlayController`).
  - `services/`: Business logic services (`AudioManager`, `GameDialogService`).
  - `models/`: Data models (e.g., `Player`).
  - `utils/`: Utility classes (`AppAssets`, `AppStrings`, `AppTextStyles`, constants, etc.).
  - `locator.dart`: Dependency injection setup.
  - `main.dart`: Application entry point.
- `assets/`: Static assets (images, audio, rive animations).

## Further Improvements (Potential)

- Add unit and widget tests.
- Implement more complex bot logic.
- Allow selection of innings (bat/bowl first).
- Improve visual design and animations.
- Refactor `goldGradientShader` out of `AppTextStyles` into a more appropriate location.
