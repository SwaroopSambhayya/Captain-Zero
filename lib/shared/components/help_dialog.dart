import 'package:captain_zero/const.dart';
import 'package:captain_zero/shared/components/custom_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showHelpDialog(BuildContext context, int level) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomDialog(
          dialogAsset: 'lib/shared/assets/images/Level$level.png',
          gifAsset: 'assets/gif/level$level.gif',
          details: getHelpDetailsonLevel(level),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      );
    },
  );
}

HelpDialogDetails getHelpDetailsonLevel(int level) {
  switch (level) {
    case 1:
      return HelpDialogDetails(
        title: game1,
        description: scoopTrashDescription,
        hintMessage: level1HintMessage,
      );
    case 2:
      return HelpDialogDetails(
        title: game2,
        description: jumbledWordDescription,
        hintMessage: level2HintMessage,
      );
    case 3:
      return HelpDialogDetails(
        title: game3,
        description: saveEarthDescription,
        hintMessage: level3HintMessage,
      );
    default:
      return const HelpDialogDetails(
          title: "", description: "", hintMessage: "");
  }
}

class HelpDialogDetails {
  final String title;
  final String description;
  final String hintMessage;
  const HelpDialogDetails({
    required this.title,
    required this.description,
    required this.hintMessage,
  });
}
