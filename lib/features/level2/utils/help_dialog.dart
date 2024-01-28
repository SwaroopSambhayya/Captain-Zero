import 'package:captain_zero/const.dart';
import 'package:captain_zero/shared/components/custom_dialog.dart';
import 'package:flutter/material.dart';

showHelpDialog(BuildContext context, int level) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomDialog(
          dialogAsset: 'lib/shared/assets/images/Level$level.png',
          details: getHelpDetailsonLevel(level),
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
