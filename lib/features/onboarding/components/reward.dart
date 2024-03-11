import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';

class Rewards extends StatelessWidget {
  const Rewards({super.key});

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'lib/shared/assets/images/certificate.png',
          width: screenWidth * 0.8,
        ),
        Text(
          "Complete all the levels to get a completion badge/pass which can be added to google wallet or showcase across social media apps",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 18, color: brandColors.brandColor5),
        )
      ],
    );
  }
}
