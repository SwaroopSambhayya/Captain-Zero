import 'package:captain_zero/features/level3/const.dart';

class Level3State {
  final double? shieldAngleRotationSpeed;
  final double? timePassed;
  final Level3Game? level3game;
  Level3State(
      {this.timePassed = 0,
      this.shieldAngleRotationSpeed = 0,
      this.level3game = Level3Game.playing});

  Level3State copyWith(
      {double? shieldAngleRotationSpeed,
      double? timePassed,
      Level3Game? level3game,
      bool? isTapLeftDown,
      bool? isTapRightDown}) {
    return Level3State(
        shieldAngleRotationSpeed:
            shieldAngleRotationSpeed ?? this.shieldAngleRotationSpeed,
        timePassed: this.timePassed,
        level3game: level3game ?? this.level3game);
  }
}
