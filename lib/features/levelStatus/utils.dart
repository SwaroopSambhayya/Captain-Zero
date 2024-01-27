import 'package:captain_zero/const.dart';

String getDescriptionBasedOnLevel(int level) {
  switch (level) {
    case 1:
      return "";

    case 2:
      return level2Description;

    case 3:
      return "";

    default:
      return "";
  }
}
