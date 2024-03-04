import 'package:captain_zero/features/level2/utils/help_dialog.dart';
import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:captain_zero/shared/components/level_app_bar.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Level3 extends StatelessWidget {
  const Level3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leadingText: "Level 3",
          iconData: Icons.help,
          onActionPress: () {
            showHelpDialog(context, 3);
          },
          title: 'Save the earth'),
      body: GameWidget(
        game: SaveTheEarth(),
      ),
    );
  }
}
