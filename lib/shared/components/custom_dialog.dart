import 'dart:ui' as ui;

import 'package:captain_zero/const.dart';
import 'package:captain_zero/features/level2/utils/help_dialog.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String dialogAsset;
  final HelpDialogDetails details;

  const CustomDialog(
      {super.key, required this.dialogAsset, required this.details});

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    double topIconSize = MediaQuery.of(context).size.width * 0.114;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: brandColors.brandColor2!,
            width: 4,
          ),
        ),
      ),
      child: CustomPaint(
        painter: RPSCustomPainter(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Transform.translate(
                offset: const Offset(0, -15),
                child: Image.asset(
                  dialogAsset,
                  width: topIconSize,
                  height: topIconSize,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 24,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 21,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15).copyWith(top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        details.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: brandColors.brandColor5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          details.description,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: brandColors.brandColor5),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: brandColors.brandColor2!,
                                    width: 1.5),
                                right: BorderSide(
                                    color: brandColors.brandColor2!,
                                    width: 1.5),
                              )),
                              child: Text(
                                "Hint",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: brandColors.brandColor5),
                              ),
                            ),
                            Text(
                              details.hintMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: brandColors.brandColor5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4244399, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.5745911, 0);
    path_0.cubicTo(
        size.width * 0.5744535,
        size.height * 0.02669046,
        size.width * 0.5736376,
        size.height * 0.05145771,
        size.width * 0.5721424,
        size.height * 0.05538209);
    path_0.cubicTo(
        size.width * 0.5688488,
        size.height * 0.07402849,
        size.width * 0.3361017,
        size.height * 0.189427,
        size.width * 0.5995155,
        size.height * 0.1189427);
    path_0.cubicTo(
        size.width * 0.4929293,
        size.height * 0.1189427,
        size.width * 0.4301822,
        size.height * 0.06402849,
        size.width * 0.4268886,
        size.height * 0.05538209);
    path_0.cubicTo(
        size.width * 0.4253934,
        size.height * 0.05145771,
        size.width * 0.4245775,
        size.height * 0.02669046,
        size.width * 0.4244399,
        0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
