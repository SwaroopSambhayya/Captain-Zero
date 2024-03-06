import 'dart:async';
import 'dart:math';

import 'package:captain_zero/features/level3/components/health_bar.dart';
import 'package:captain_zero/features/level3/components/orb.dart';
import 'package:captain_zero/features/level3/components/play_pause.dart';
import 'package:captain_zero/features/level3/components/player.dart';
import 'package:captain_zero/features/level3/components/timer.dart';
import 'package:captain_zero/features/level3/const.dart';
import 'package:captain_zero/features/level3/effects/camera_zoom_effect.dart';
import 'package:captain_zero/features/level3/providers/game_state_provider.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

class SaveTheEarth extends FlameGame<MyWorld>
    with HasCollisionDetection, KeyboardEvents, RiverpodGameMixin {
  SaveTheEarth({required this.screenSize, required this.routerContext})
      : super(
          world: MyWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 600,
          ),
        );
  final Size screenSize;
  final BuildContext routerContext;
  late HealthBar healthBar;
  late GameTimer gameTimer;

  @override
  void onLoad() async {
    Flame.images.loadAll(
      [
        ...List.generate(8, (index) => 'flame/flame${index + 1}.png'),
        ...List.generate(2, (index) => 'snow/snowflake${index + 1}.png'),
        ...List.generate(2, (index) => 'sparkle/sparkle${index + 1}.png'),
        'two-way-arrow.png'
      ],
    );

    await add(
      healthBar = HealthBar(),
    );
    await add(
      PlayPause(size: 60, position: Vector2(screenSize.width - 130, 20)),
    );
    await add(gameTimer = GameTimer());
  }

  Random rnd = Random();

  // @override
  // void render(Canvas canvas) {
  //   //canvas.drawImage(AssetImage(assetName), offset, paint)
  //   //print('rendering canvas');
  //   super.render(canvas);
  // }

  void onOrbHit(RayType type) async {
    await camera.viewfinder.add(
      MoveEffect.by(
        Vector2(8, 8),
        PerlinNoiseEffectController(
          duration: 1,
          frequency: 400,
        ),
      ),
    );
    healthBar.healthBarValue.change(healthBar.healthBarValue.value - 10.0);
  }
}

class MyWorld extends World
    with HasGameRef<SaveTheEarth>, TapCallbacks, RiverpodComponentMixin {
  double lastSpawnOrbTimer = 0.0;
  late Earth player;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(
      player = Earth(),
    );

    add(CameraZoomEffect(
      controller: EffectController(
        duration: 1.0,
      ),
      zoomTo: 1.0,
    ));
  }

  @override
  void update(double dt) {
    lastSpawnOrbTimer += dt;
    if (lastSpawnOrbTimer >= 2.5) {
      lastSpawnOrbTimer = 0.0;
      spawnOrb();
    }
    if (game.healthBar.healthBarValue.value == 0) {
      Future.delayed(const Duration(milliseconds: 500), () {
        ref.read(level3State.notifier).changeGameState(Level3Game.gameOver);
        game.pauseEngine();
      });
    }
    super.update(dt);
  }

  void spawnOrb() {
    final distance = (game.size.x / 2) + (game.size.x * 0.05);
    final angle = Random().nextDouble() * pi * 2;
    final position = Vector2(cos(angle), sin(angle)) * distance;
    final moveSpeed = Level3Constants.spawnOrbsMoveSpeedRange.random();
    add(
      Orb(
        type: RayType.values.random(),
        speed: moveSpeed,
        size: 16 + Random().nextDouble() * 2,
        target: game.world.player,
        position: position.clone(),
      ),
    );
  }
}
