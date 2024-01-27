import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function() onTap;
  const CustomButton(
      {super.key, required this.title, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;
    return NeoPopButton(
      color: colors.brandColor1!,
      shadowColor: colors.brandColor2,
      onTapUp: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 80.0,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: colors.brandColor5),
            ),
            if (icon != null)
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_right_alt),
              )
          ],
        ),
      ),
    );
  }
}
