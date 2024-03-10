import 'dart:math';

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'lib/shared/assets/images/Level${index + 1}.png',
              width: 70,
            ).animate(
              onComplete: (controller) {
                controller.reverse();
              },
            )..moveY(
                begin: 0,
                end: 10,
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
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList,
        )
      ],
    );
  }
}
