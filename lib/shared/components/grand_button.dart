import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class GrandButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  const GrandButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: onPress,
      decoration: NeoPopTiltedButtonDecoration(
        color: colors.brandColor1!,
        plunkColor: Colors.grey.shade900,
        shadowColor: colors.brandColor2!,
        showShimmer: true,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 70.0,
          vertical: 15,
        ),
        child: Text(
          text,
          style:
              TextStyle(color: colors.brandColor5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
