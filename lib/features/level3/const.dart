import 'package:captain_zero/features/level3/models/double_range.dart';
import 'package:flutter/material.dart';

class Level3Constants {
  static const orbsSpawnEveryInitial = 2.5;
  static const orbsSpawnEveryPeak = 0.65;
  static const orbsMoveSpeedInitial = DoubleRange(min: 100, max: 120);
  static const orbsMoveSpeedPeak = DoubleRange(min: 190, max: 210);
  static DoubleRange get spawnOrbsMoveSpeedRange => DoubleRange.lerp(
        orbsMoveSpeedInitial,
        orbsMoveSpeedPeak,
        0.5,
      );
  static const uvcColors = [
    Color(0xFFFF9362),
    Color(0xFFFF5900),
    Color(0xFFFF2F00),
  ];

  static final uvbColors = [
    Colors.deepPurple.shade300,
    Colors.deepPurpleAccent,
    Colors.deepPurple,
  ];
  static const double bgVolume = 0.2;
}

enum RayType {
  uvc,
  uvb;

  Color get baseColor => switch (this) {
        RayType.uvc => Level3Constants.uvcColors.first,
        RayType.uvb => Level3Constants.uvbColors.first,
      };

  List<Color> get colors => switch (this) {
        RayType.uvc => Level3Constants.uvcColors,
        RayType.uvb => Level3Constants.uvbColors,
      };
}

enum Level3Game {
  playing,
  paused,
  gameOver,
}
