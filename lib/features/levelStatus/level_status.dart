import 'package:captain_zero/features/level3/providers/audio_provider.dart';
import 'package:captain_zero/features/levelStatus/utils.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class LevelCompleted extends ConsumerStatefulWidget {
  const LevelCompleted({super.key, required this.level});
  final int level;

  @override
  ConsumerState<LevelCompleted> createState() => _LevelCompletedState();
}

class _LevelCompletedState extends ConsumerState<LevelCompleted> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(audioProvider).playVictorySound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Congratulations!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                LottieBuilder.asset('lib/shared/assets/confetti.json'),
                Image.asset(
                  'lib/shared/assets/images/Level${widget.level}.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
            Text(
              "Level ${widget.level} completed!",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                getDescriptionBasedOnLevel(widget.level),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: widget.level <= 3,
              child: Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GrandButton(
                    onPress: () {
                      if (widget.level < 3) {
                        context.go('/level${widget.level + 1}');
                      }
                    },
                    text: "Continue Journey!",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
