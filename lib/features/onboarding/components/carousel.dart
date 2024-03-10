import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const Carousel({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;

    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 15,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            width: 20,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: currentIndex == index
                    ? brandColors.brandColor5
                    : brandColors.brandColor1,
                border:
                    Border.all(color: brandColors.brandColor5!, width: 0.5)),
          ),
        ),
        itemCount: 3,
      ),
    );
  }
}
