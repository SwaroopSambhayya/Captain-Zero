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
  static const hotColors = [
    Color(0xFFFF9362),
    Color(0xFFFF5900),
    Color(0xFFFF2F00),
  ];

  static const coldColors = [
    Color(0xFFB4E6FF),
    Color(0xFF00AFFF),
    Color(0xFF008BFF),
  ];
}

enum TemperatureType {
  hot,
  cold;

  Color get baseColor => switch (this) {
        TemperatureType.hot => Level3Constants.hotColors.first,
        TemperatureType.cold => Level3Constants.coldColors.first,
      };

  List<Color> get colors => switch (this) {
        TemperatureType.hot => Level3Constants.hotColors,
        TemperatureType.cold => Level3Constants.coldColors,
      };
}

enum OrbType {
  uvc,
  uvb;

  bool get isUvc => this == OrbType.uvc;

  bool get isUvb => this == OrbType.uvb;

  List<Color> get colors => Level3Constants.coldColors;

  Color get baseColor => colors.first;
}
