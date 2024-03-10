import 'package:captain_zero/shared/components/help_dialog.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialog extends StatelessWidget {
  final String dialogAsset;
  final String gifAsset;
  final HelpDialogDetails details;
  final Function() onPressed;

  const CustomDialog(
      {super.key,
      required this.dialogAsset,
      required this.details,
      required this.gifAsset,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    double topIconSize = MediaQuery.of(context).size.width * 0.169;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
                offset: const Offset(0, 14),
                child: Image.asset(
                  dialogAsset,
                  width: topIconSize,
                  height: topIconSize,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 35,
              child: IconButton(
                iconSize: 24,
                onPressed: onPressed,
                icon: const Icon(
                  Icons.close,
                  size: 21,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15).copyWith(top: 20),
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
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
                                        ?.copyWith(
                                            color: brandColors.brandColor5),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  details.hintMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: brandColors.brandColor5),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
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
                                    ),
                                  ),
                                  child: Text(
                                    "Demo",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: brandColors.brandColor5),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: SizedBox(
                                      child: Image.asset(
                                        gifAsset,
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
    Paint paint = Paint()..color = Colors.black.withOpacity(1.0);
    Path path = Path();

    // size of the hexagon placeholder
    double hexagonWidth = 68; // The full width of the hexagon
    double hexagonHeight = 68; // The full height of the hexagon

    // Calculate the cutout's coordinates based on the hexagon's dimensions
    double hexagonCenterX = size.width / 2;
    double hexagonCenterY = 0; // Since we are accommodating the bottom half

    //points for the hexagon
    double leftX = hexagonCenterX - hexagonWidth / 2;
    double rightX = hexagonCenterX + hexagonWidth / 2;
    double middleY = hexagonCenterY + hexagonHeight / 2;
    double bottomY = hexagonCenterY + hexagonHeight;

    // Start from the left middle point and draw the bottom half of the hexagon
    path.moveTo(leftX, middleY); // Left middle point
    path.lineTo(leftX, bottomY); // Left bottom point
    path.lineTo(hexagonCenterX, bottomY + (hexagonHeight / 4)); // Bottom point
    path.lineTo(rightX, bottomY); // Right bottom point
    path.lineTo(rightX, middleY); // Right middle point

    // Draw the rest of the dialog box
    path.lineTo(size.width, middleY); // Right top corner of the dialog
    path.lineTo(size.width, size.height); // Bottom right corner of the dialog
    path.lineTo(0, size.height); // Bottom left corner of the dialog
    path.lineTo(0, middleY); // Left top corner of the dialog
    path.close(); // Automatically connects back to the start point (left middle)

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
