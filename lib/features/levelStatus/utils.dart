import 'package:captain_zero/const.dart';

String getDescriptionBasedOnLevel(int level) {
  switch (level) {
    case 1:
      return level1Description;

    case 2:
      return level2Description;

    case 3:
      return level3Description;

    default:
      return "";
  }
}
