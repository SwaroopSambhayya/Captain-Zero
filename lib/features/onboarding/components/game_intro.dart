import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameIntro extends StatefulWidget {
  const GameIntro({super.key});

  @override
  State<GameIntro> createState() => _GameIntroState();
}

class _GameIntroState extends State<GameIntro> {
  late List<Widget> imageList;
  @override
  void initState() {
    super.initState();
    imageList = List.generate(
      3,
      (index) => Padding(
        padding: EdgeInsets.only(left: 10.0, top: (2 - index) * 40),
        child: Column(
          children: [
            Image.asset(
              'lib/shared/assets/images/Level${index + 1}.png',
              width: 70,
            ).animate(
              delay: Duration(milliseconds: index * 500),
              onComplete: (controller) {
                controller.loop(reverse: true);
              },
            )
              ..fadeIn(
                  delay: Duration(milliseconds: index * 500),
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  curve: Curves.easeInOut)
              ..moveY(
                delay: const Duration(milliseconds: 1000),
                begin: -7,
                end: 0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1000),
              ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30 + index * 40,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    gameTheme.cardColor,
                    gameTheme.cardColor.withOpacity(0.5)
                  ],
                ),
              ),
            ).animate()
              ..scaleY(
                  delay: Duration(milliseconds: index * 500),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  begin: 0)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Text(
            "This game consists of 3 levels, each level has it's own significance on planet sustainability. Complete each level and spread awareness on planet sustainability in a fun way!",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: brandColors.brandColor5),
          ),
        )
      ],
    );
  }
}
