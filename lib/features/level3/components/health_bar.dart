import 'dart:async';

import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent with HasGameRef<SaveTheEarth> {
  late SMINumber healthBarValue;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final healthbarBoard =
        await loadArtboard(RiveFile.asset('assets/rive/energy_bar.riv'));
    final controller = StateMachineController.fromArtboard(
      healthbarBoard,
      "State Machine 1",
    )!;
    healthbarBoard.addController(controller);
    healthBarValue = controller.findInput<double>('Energy') as SMINumber;
    add(
      RiveComponent(
        artboard: healthbarBoard,
        size: Vector2.all(160),
        position: Vector2(80, 50),
        anchor: Anchor.center,
      ),
    );
  }
}
