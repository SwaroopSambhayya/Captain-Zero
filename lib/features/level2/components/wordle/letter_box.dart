import 'package:captain_zero/features/level2/components/wordle/empty_box.dart';
import 'package:captain_zero/features/level2/components/wordle/wordle.dart';
import 'package:captain_zero/features/level2/providers/score_tracker.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LetterBox extends ConsumerStatefulWidget {
  final String data;
  final Function()? onAccepted;

  const LetterBox({super.key, required this.data, this.onAccepted});

  @override
  ConsumerState<LetterBox> createState() => _LetterBoxState();
}

class _LetterBoxState extends ConsumerState<LetterBox> {
  bool isAccepted = false;
  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;

    return isAccepted
        ? Container(
            margin: const EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
          )
        : Draggable<String>(
            onDragCompleted: () {
              setState(() {
                isAccepted = true;
                widget.onAccepted!();
              });
            },
            data: widget.data,
            feedback: LetterBox(
              data: widget.data,
            ),
            childWhenDragging: EmptyLetterBox(
              borderColor: colors.borderColor2,
              ignoreHighlight: true,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: colors.brandColor1!,
                      strokeAlign: BorderSide.strokeAlignInside)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: colors.brandColor3,
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: colors.borderColor3!,
                    ),
                    right: BorderSide(
                      width: 3,
                      color: colors.borderColor3!,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    widget.data,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: colors.brandColor1),
                  ),
                ),
              ),
            ),
          );
  }
}
