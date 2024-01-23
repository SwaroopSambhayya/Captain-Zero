import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class GrandButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  const GrandButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: () {},
      decoration: NeoPopTiltedButtonDecoration(
        color: Colors.black,
        plunkColor: Colors.grey.shade900,
        shadowColor: const Color(0xff45C074),
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
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
