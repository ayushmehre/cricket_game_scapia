# Hand Cricket Game

A simple implementation of the Hand Cricket game built with Flutter. This project was created as part of an assignment.

## Demo

[![Hand Cricket Gameplay Demo](https://img.youtube.com/vi/lpYZ6dQeJVg/0.jpg)](https://youtube.com/shorts/lpYZ6dQeJVg?feature=share)

_(Click the image above to view a short gameplay demo)_

## Overview

This project demonstrates a basic Hand Cricket game where the user plays against a bot. The game involves choosing numbers (1-6) simultaneously. If the numbers match, the batsman is out. Otherwise, the batsman scores the runs they chose. The user bats first, followed by the bot.

## Features

- Simple Hand Cricket gameplay (User bats first, then bowls).
- Score tracking for user and bot.
- Target score displayed during the chase.
- Turn-based timer (10 seconds per choice), with timeout resulting in a loss for the player whose turn it was.
- Sound effects for game events (six, out, win, lose, etc.) and background music.
- Clear UI displaying scores, player status (Batting/Bowling), target score, balls left, and timer.
- Intermediate display showing user and bot number choices after selection.
- Game result overlays (Win, Lose, Tie, Out, Sixer) with appropriate status colors.

## Architecture & Libraries Used

- **State Management:** `flutter_bloc` / `cubit` (`GameCubit`) for managing the core game logic and state (`GameState`).
- **Dependency Injection:** `get_it` is used to manage singleton dependencies like controllers and services.
- **Audio:** `audioplayers` for background music and sound effects, managed via `GameAudioController`.
- **UI Structure:** Separated UI components (widgets) for better organization (e.g., `ScoreboardWidget`, `NumberInputGridWidget`, `TurnInfoWidget`).
- **Controllers/Services:** Logic for UI concerns like audio (`GameAudioController`), overlays (`GameOverlayController`), and dialogs (`GameDialogService`) are extracted from the main view state.
- **Code Style:** Follows standard Flutter linting rules.
- **Assets & Styles:** Centralized management of strings (`AppStrings`), assets (`AppAssets`), text styles (`AppTextStyles`), constants (`AppConstants`), and decorations (`AppDecorations`).

## Getting Started

1.  **Ensure Flutter is installed.** See [Flutter documentation](https://docs.flutter.dev/get-started/install).
2.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd cricket_game_scapia
    ```
3.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## Project Structure (Key Directories)

- `lib/`: Main application code.
  - `cubit/`: Contains the `GameCubit` and `GameState`.
  - `screens/`: UI screens (`start_screen.dart`, `game_screen.dart`).
  - `widgets/`: Reusable UI components, categorized by screen.
  - `controllers/`: UI-specific controllers (`GameAudioController`, `GameOverlayController`).
  - `services/`: Business logic services (`GameDialogService`).
  - `models/`: Data models (e.g., `Player`).
  - `utils/`: Utility classes (`AppAssets`, `AppStrings`, `AppTextStyles`, `AppConstants`, `AppDecorations`).
  - `locator.dart`: Dependency injection setup.
  - `main.dart`: Application entry point.
- `assets/`: Static assets (images, audio).

## Further Improvements (Potential)

- Add unit and widget tests.
- Implement more complex bot logic (e.g., defensive bowling when target is low).
- Allow selection of innings (bat/bowl first) or number of overs.
- Improve visual design (e.g., custom fonts, more engaging overlays).
- Add loading indicators for assets if needed.
