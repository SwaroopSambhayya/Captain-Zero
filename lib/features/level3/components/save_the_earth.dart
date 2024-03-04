import 'dart:async';
import 'dart:math';

import 'package:captain_zero/features/level3/components/orb.dart';
import 'package:captain_zero/features/level3/components/player.dart';
import 'package:captain_zero/features/level3/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_noise/flame_noise.dart';

class SaveTheEarth extends FlameGame<MyWorld>
    with HasCollisionDetection, KeyboardEvents {
  SaveTheEarth()
      : super(
          world: MyWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 600,
          ),
        );
  @override
  void onLoad() {
    Flame.images.loadAll(
      [
        ...List.generate(8, (index) => 'flame/flame${index + 1}.png'),
        ...List.generate(2, (index) => 'snow/snowflake${index + 1}.png'),
        ...List.generate(2, (index) => 'sparkle/sparkle${index + 1}.png'),
        'two-way-arrow.png'
      ],
    );
  }

  Random rnd = Random();

  @override
  void update(double dt) {
    //print(dt);
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    //canvas.drawImage(AssetImage(assetName), offset, paint)
    //print('rendering canvas');
    super.render(canvas);
  }

  void onOrbHit(TemperatureType type) {
    camera.viewfinder.add(
      MoveEffect.by(
        Vector2(8, 8),
        PerlinNoiseEffectController(
          duration: 1,
          frequency: 400,
        ),
      ),
    );
  }
}

class MyWorld extends World with HasGameRef<SaveTheEarth> {
  double lastSpawnOrbTimer = 0.0;
  late Earth player;
  @override
  Future<void> onLoad() async {
    await add(
      player = Earth(),
    );
  }

  @override
  void update(double dt) {
    lastSpawnOrbTimer += dt;
    if (lastSpawnOrbTimer >= 2.5) {
      lastSpawnOrbTimer = 0.0;
      spawnOrb();
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
        type: TemperatureType.values.random(),
        speed: moveSpeed,
        size: 16 + Random().nextDouble() * 2,
        target: game.world.player,
        position: position.clone(),
      ),
    );
  }
}
