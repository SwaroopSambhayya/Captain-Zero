import 'package:captain_zero/features/level3/providers/audio_provider.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class GameOverUI extends ConsumerStatefulWidget {
  final Function() onTryAgain;
  const GameOverUI({super.key, required this.onTryAgain});

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
    ref.read(audioProvider).playGameOverMusic();
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
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.96)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: brandColors.brandColor5),
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
            GrandButton(
              text: 'TRY AGAIN!',
              onPress: widget.onTryAgain,
            ),
          ],
        ),
      ],
    );
  }
}
