import 'package:cricket_game_scapia/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Manages and displays the Rive character animation.
class CharacterAnimationWidget extends StatefulWidget {
  const CharacterAnimationWidget({super.key});

  @override
  CharacterAnimationWidgetState createState() =>
      CharacterAnimationWidgetState();
}

class CharacterAnimationWidgetState extends State<CharacterAnimationWidget> {
  Artboard? _riveArtboard;
  StateMachineController? _stateMachineController;
  SMIInput<bool>? _throwTrigger; // Input to trigger the throw animation

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRiveAsset();
  }

  /// Loads the Rive file and initializes the state machine.
  void _loadRiveAsset() async {
    setState(() => _isLoading = true);
    try {
      final file = await RiveFile.asset(AppAssets.rive.character);
      final artboard = file.mainArtboard;
      // Find the state machine by name (replace 'CricketStateMachine' if different)
      var controller = StateMachineController.fromArtboard(
        artboard,
        'CricketStateMachine',
      );
      if (controller != null) {
        artboard.addController(controller);
        // Find the trigger input by name (replace 'ThrowTrigger' if different)
        _throwTrigger = controller.findInput<bool>('ThrowTrigger');
      }
      if (mounted) {
        setState(() {
          _riveArtboard = artboard;
          _stateMachineController = controller;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading Rive asset: $e");
      if (mounted) {
        setState(() => _isLoading = false); // Stop loading on error
        // Optionally show an error message in the UI
      }
    }
  }

  /// Triggers the 'Throw' animation in the state machine.
  void playThrow() {
    // Ensure trigger exists and set its value to true
    // The state machine should handle resetting it after the animation.
    if (_throwTrigger?.value == false) {
      // Only trigger if not already true
      _throwTrigger?.value = true;
    }
    // Optionally, add a short delay before resetting if state machine doesn't auto-reset
    // Future.delayed(const Duration(milliseconds: 100), () => _throwTrigger?.value = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_riveArtboard == null) {
      // Handle error state - Rive file failed to load
      return const Center(
        child: Icon(Icons.error, color: Colors.red, size: 50),
      );
    }
    return Rive(artboard: _riveArtboard!);
  }
}
