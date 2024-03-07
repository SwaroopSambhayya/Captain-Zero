import 'dart:ui';

import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';

class CameraZoomEffect extends Effect with HasGameRef<SaveTheEarth> {
  CameraZoomEffect({
    required EffectController controller,
    required this.zoomTo,
  }) : super(controller);

  final double zoomTo;
  late double zoomFrom;

  @override
  void onStart() {
    zoomFrom = game.camera.viewfinder.zoom;
    super.onStart();
  }

  @override
  void apply(double progress) {
    game.camera.viewfinder.zoom = lerpDouble(zoomFrom, zoomTo, progress)!;
  }
}
