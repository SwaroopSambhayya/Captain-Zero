// ignore_for_file: library_private_types_in_public_api
import 'package:captain_zero/features/level2/components/wordle/wordle.dart';
import 'package:captain_zero/shared/components/help_dialog.dart';
import 'package:captain_zero/shared/components/level_app_bar.dart';
import 'package:captain_zero/shared/enums.dart';
import 'package:captain_zero/shared/providers/game_state.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Level2 extends ConsumerStatefulWidget {
  const Level2({super.key});

  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends ConsumerState<Level2> {
  bool _isDialogShown = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showHelpDialog(context, 2);
      setState(() {
        _isDialogShown = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isDialogShown
          ? Column(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 30)
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
            )
          : Container(
              color: colors.brandColor5,
            ),
    );
  }
}
