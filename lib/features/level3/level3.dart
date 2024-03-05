import 'package:captain_zero/features/level2/utils/help_dialog.dart';
import 'package:captain_zero/features/level3/components/game_over_ui.dart';
import 'package:captain_zero/features/level3/components/rotating_controls.dart';
import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:captain_zero/features/level3/const.dart';
import 'package:captain_zero/features/level3/providers/game_state_provider.dart';
import 'package:captain_zero/shared/components/level_app_bar.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

class Level3 extends ConsumerStatefulWidget {
  const Level3({super.key});

  @override
  ConsumerState<Level3> createState() => _Level3State();
}

class _Level3State extends ConsumerState<Level3> {
  @override
  Widget build(BuildContext context) {
    final levelState = ref.read(level3State.notifier);

    ref.listen(level3State, (previous, next) {
      if (next.level3game == Level3Game.playing &&
          next.level3game != previous?.level3game) {
        setState(() {});
      }
    });
    return Scaffold(
      appBar: CustomAppBar(
          leadingText: "Level 3",
          iconData: Icons.help,
          onActionPress: () {
            showHelpDialog(context, 3);
          },
          title: 'Save the earth'),
      body: Stack(
        children: [
          RiverpodAwareGameWidget(
            key: gameWidgetKey,
            game: SaveTheEarth(screenSize: MediaQuery.of(context).size),
          ),
          RotationControls(
              onLeftDown: levelState.onLeftTapDown,
              onLeftUp: levelState.onLeftTapUp,
              onRightDown: levelState.onRightTapDown,
              onRightUp: levelState.onRightTapUp),
          Consumer(builder: (context, ref, child) {
            final level3GameState = ref.watch(
              level3State.select((value) => value.level3game),
            );
            if (level3GameState == Level3Game.gameOver) {
              return const GameOverUI();
            }

            return const SizedBox();
          }),
        ],
      ),
    );
  }
}
