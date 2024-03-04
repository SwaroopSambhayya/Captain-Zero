import 'dart:math';
import 'package:captain_zero/features/level3/components/moving_orb_tail_particles.dart';
import 'package:captain_zero/features/level3/components/orb_disjoint_particle.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import '../const.dart';

part './moving_orb.dart';

sealed class MovingComponent extends PositionComponent
    with HasGameRef<SaveTheEarth>, HasTimeScale {
  MovingComponent({
    required this.speed,
    required double size,
    required this.target,
    required super.position,
  }) : super(size: Vector2.all(size), priority: 1);

  final double speed;
  final PositionComponent target;

  Random get rnd => game.rnd;

  @override
  void update(double dt) {
    super.update(dt);
    final angle = atan2(
      target.position.y - position.y,
      target.position.x - position.x,
    );
    position += Vector2(cos(angle), sin(angle)) * speed * dt;
  }
}
