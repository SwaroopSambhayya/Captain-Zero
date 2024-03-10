import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CaptainZero extends StatelessWidget {
  const CaptainZero({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.3,
          child: const RiveAnimation.asset(
            'lib/shared/assets/earth.riv',
            alignment: Alignment.centerRight,
          ),
        ),
        Transform.rotate(
          angle: -pi / 4,
          child: LottieBuilder.asset(
            'lib/shared/assets/hero.json',
            width: screenWidth,
            alignment: Alignment.centerLeft,
            height: screenHeight * 0.2,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                      "Captain Zero, begin your journey towards the planet sustainability",
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      speed: const Duration(milliseconds: 100),
                      textAlign: TextAlign.center),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
