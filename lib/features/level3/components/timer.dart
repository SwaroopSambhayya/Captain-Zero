import 'dart:async';

import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:captain_zero/features/level3/providers/audio_provider.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameTimer extends PositionComponent
    with HasGameRef<SaveTheEarth>, RiverpodComponentMixin {
  late Timer gameTimer;
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
  );
  int totalMinutes = 120;
  @override
  FutureOr<void> onLoad() {
    gameTimer = Timer(1, onTick: () {
      totalMinutes--;
    }, repeat: true);

    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameTimer.update(dt);
    if (totalMinutes == 0) {
      gameTimer.stop();
      game.pauseEngine();
      game.routerContext.go('/levelComplete/3');
      ref.read(audioProvider).stopMusic();
      ref.read(audioProvider).playVictorySound();
    }
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(canvas, getFormattedTime(totalMinutes),
        Vector2(game.screenSize.width - 65, 40));
  }

  String getFormattedTime(int time) {
    String minutes = (totalMinutes / 60).floor().toString();
    if (minutes.length == 1) minutes = "0$minutes";
    String seconds = (totalMinutes % 60).toString();
    if (seconds.length == 1) seconds = "0$seconds";
    return "$minutes:$seconds";
  }
}
