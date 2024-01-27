import 'package:captain_zero/features/levelStatus/utils.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:captain_zero/shared/components/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LevelCompleted extends StatelessWidget {
  final int level;
  const LevelCompleted({super.key, required this.level});

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
                  'lib/shared/assets/images/Level$level.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
            Text(
              "Level $level completed!",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                getDescriptionBasedOnLevel(level),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GrandButton(onPress: () {}, text: "Continue Journey!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
