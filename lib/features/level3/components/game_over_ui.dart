import 'dart:ui';

import 'package:captain_zero/features/level3/const.dart';
import 'package:captain_zero/features/level3/providers/game_state_provider.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class GameOverUI extends ConsumerStatefulWidget {
  const GameOverUI({super.key});

  @override
  ConsumerState<GameOverUI> createState() => _GameOverUIState();
}

class _GameOverUIState extends ConsumerState<GameOverUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _gameOverAnimationController;

  @override
  void initState() {
    _gameOverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _gameOverAnimationController.addListener(() {
      setState(() {});
    });
    _gameOverAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _gameOverAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: Tween<double>(begin: 0.0, end: 16.0).transform(
              _gameOverAnimationController.value,
            ),
            sigmaY: Tween<double>(begin: 0.0, end: 16.0).transform(
              _gameOverAnimationController.value,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(
              Tween<double>(begin: 0.0, end: 0.7).transform(
                _gameOverAnimationController.value,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              child: const RiveAnimation.asset(
                'assets/rive/earth_sad.riv',
                artboard: "Earth Sad",
                stateMachines: ['State Machine 1'],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 240,
              child: GrandButton(
                text: 'TRY AGAIN!',
                onPress: () {
                  ref
                      .read(level3State.notifier)
                      .changeGameState(Level3Game.playing);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
