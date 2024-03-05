import 'dart:async';
import 'dart:math';

import 'package:captain_zero/features/level3/components/orb.dart';
import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:captain_zero/features/level3/components/shield.dart';
import 'package:captain_zero/features/level3/const.dart';
import 'package:captain_zero/features/level3/providers/game_state_provider.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

class Earth extends PositionComponent
    with HasGameRef<SaveTheEarth>, CollisionCallbacks, RiverpodComponentMixin {
  Earth({
    double size = 100,
  }) : super(
          size: Vector2.all(size),
          position: Vector2.all(0),
          anchor: Anchor.center,
        );
  double get radius => size.x / 2;
  late SMITrigger uvcTrigger;
  late SMITrigger uvbTrigger;
  late Shield uvcShield;
  late Shield uvbShield;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(
      CircleHitbox(
        collisionType: CollisionType.active,
        radius: radius * 0.8,
        position: size / 2,
        anchor: Anchor.center,
      ),
    );
    final earthArtBoard =
        await loadArtboard(RiveFile.asset('assets/rive/earth.riv'));
    final controller = StateMachineController.fromArtboard(
      earthArtBoard,
      "State Machine 1",
    )!;
    uvcTrigger = controller.findInput<bool>('uv-c') as SMITrigger;
    uvbTrigger = controller.findInput<bool>('uv-b') as SMITrigger;
    earthArtBoard.addController(controller);
    add(
      RiveComponent(
          artboard: earthArtBoard,
          size: Vector2.all(152),
          anchor: Anchor.center,
          position: size / 2),
    );
    add(
      uvcShield = Shield(type: RayType.uvc),
    );
    add(
      uvbShield = Shield(type: RayType.uvb),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final rotationSpeed = ref.read(level3State).shieldAngleRotationSpeed;
    if (rotationSpeed != 0) {
      uvcShield.angle += rotationSpeed! * dt;
    }
    uvbShield.angle = uvcShield.angle - pi;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Orb) {
      game.onOrbHit(other.type);
      switch (other.type) {
        case RayType.uvc:
          uvcTrigger.fire();
          break;
        case RayType.uvb:
          uvbTrigger.fire();
          break;
      }
      other.removeFromParent();
    }
  }
}
