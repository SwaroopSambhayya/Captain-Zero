import 'package:captain_zero/features/level2/components/wordle/wordle.dart';
import 'package:captain_zero/features/level2/utils/help_dialog.dart';
import 'package:captain_zero/shared/components/level_App_bar.dart';
import 'package:captain_zero/shared/enums.dart';
import 'package:captain_zero/shared/providers/game_state.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Level2 extends ConsumerWidget {
  const Level2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;
    ref.listen(gameState, (prev, next) {
      if (next == GameState.level2Completed) {
        context.go('/levelComplete/2');
      }
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: "Jumble and Scramble",
        leadingText: "Level 2",
        iconData: Icons.help,
        onActionPress: () {
          showHelpDialog(context, 2);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 60)
                  .copyWith(right: 15),
              decoration: BoxDecoration(
                color: colors.brandColor2,
                boxShadow: [
                  BoxShadow(
                    color: colors.borderColor2!,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: const Wordle(),
            ),
          ),
        ],
      ),
    );
  }
}
