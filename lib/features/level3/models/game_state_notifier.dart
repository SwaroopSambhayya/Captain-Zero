import 'dart:math';

import 'package:captain_zero/features/level3/const.dart';
import 'package:captain_zero/features/level3/models/level_3_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStateNotifier extends StateNotifier<Level3State> {
  GameStateNotifier()
      : super(
          Level3State(),
        );
  final _shieldAngleRotationAmount = pi * 1.8;
  bool isTapLeftDown = false;
  bool isTapRightDown = false;

  void _changeRotationSpeed(double speed) {
    state = state.copyWith(
      shieldAngleRotationSpeed:
          speed.clamp(-_shieldAngleRotationAmount, _shieldAngleRotationAmount),
    );
  }

  void changeGameState(Level3Game gameState) {
    state = state.copyWith(level3game: gameState);
  }

  void onLeftTapDown() {
    isTapLeftDown = true;

    _changeRotationSpeed(-_shieldAngleRotationAmount);
  }

  void onLeftTapUp() {
    isTapLeftDown = false;
    if (isTapRightDown) {
      _changeRotationSpeed(_shieldAngleRotationAmount);
    } else {
      _changeRotationSpeed(0.0);
    }
  }

  void onRightTapDown() {
    isTapRightDown = true;
    _changeRotationSpeed(_shieldAngleRotationAmount);
  }

  void onRightTapUp() {
    isTapRightDown = false;
    if (isTapLeftDown) {
      _changeRotationSpeed(-_shieldAngleRotationAmount);
    } else {
      _changeRotationSpeed(0.0);
    }
  }
}
