import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String leadingText;

  final String title;

  final IconData? iconData;

  final Function() onActionPress;

  const CustomAppBar(
      {super.key,
      this.iconData,
      required this.leadingText,
      required this.onActionPress,
      required this.title});

  @override
  Size get preferredSize {
    return const Size.fromHeight(60.0);
  }

  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;
    return AppBar(
      leadingWidth: 80,
      backgroundColor: colors.brandColor5,
      actions: [
        GestureDetector(
          onTap: onActionPress,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Stack(
              children: [
                Positioned(
                  left: 2.2,
                  top: 2.2,
                  child: Icon(
                    Icons.circle,
                    color: colors.brandColor2,
                  ),
                ),
                Icon(
                  iconData,
                  color: colors.brandColor1,
                ),
              ],
            ),
          ),
        )
      ],
      leading: Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        child: Stack(
          children: [
            Positioned(
              left: 8,
              top: 4,
              child: Container(
                width: 60,
                height: 30,
                color: colors.brandColor2,
              ),
            ),
            Container(
              width: 60,
              height: 30,
              margin: const EdgeInsets.only(left: 4),
              alignment: Alignment.center,
              color: colors.brandColor1,
              child: Text(
                leadingText,
                style: TextStyle(color: colors.brandColor5),
              ),
            ),
          ],
        ),
      ),
      title: Text(
        title,
      ),
    );
  }
}
