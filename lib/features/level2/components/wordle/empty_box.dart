import 'package:captain_zero/features/level2/components/wordle/letter_box.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EmptyLetterBox extends StatefulWidget {
  const EmptyLetterBox(
      {super.key,
      this.borderColor,
      this.dataToAccept,
      this.ignoreHighlight = false});

  final Color? borderColor;
  final bool ignoreHighlight;
  final String? dataToAccept;

  @override
  State<EmptyLetterBox> createState() => _EmptyLetterBoxState();
}

class _EmptyLetterBoxState extends State<EmptyLetterBox> {
  bool isDataMatch = false;
  bool isHighlighted = false;
  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9),
      child: isDataMatch
          ? LetterBox(data: widget.dataToAccept!)
          : DragTarget<String>(onWillAccept: (data) {
              if (data == widget.dataToAccept) {
                return true;
              }

              return false;
            }, onAccept: (data) {
              setState(() {
                isDataMatch = true;
              });
            }, onLeave: (data) {
              if (!widget.ignoreHighlight) {
                setState(() {
                  isHighlighted = true;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    isHighlighted = false;
                  });
                });
              }
            }, builder: (context, candidateData, rejectedData) {
              return DottedBorder(
                borderType: BorderType.RRect,
                padding: const EdgeInsets.all(2),
                color: isHighlighted
                    ? Colors.redAccent
                    : widget.borderColor ?? colors.brandColor1!,
                strokeWidth: 2,
                dashPattern: const [8, 4],
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: colors.brandColor5!.withOpacity(0.12),
                  ),
                ),
              );
            }),
    );
  }
}
