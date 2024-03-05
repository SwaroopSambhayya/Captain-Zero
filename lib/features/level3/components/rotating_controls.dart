import 'package:captain_zero/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RotationControls extends StatefulWidget {
  const RotationControls({
    super.key,
    required this.onLeftDown,
    required this.onLeftUp,
    required this.onRightDown,
    required this.onRightUp,
  });

  final VoidCallback onLeftDown;
  final VoidCallback onLeftUp;
  final VoidCallback onRightDown;
  final VoidCallback onRightUp;

  @override
  State<RotationControls> createState() => _RotationControlsState();
}

class _RotationControlsState extends State<RotationControls> {
  bool showGuide = true;
  @override
  Widget build(BuildContext context) {
    const bottomPadding = 40.0;
    const edgePadding = 44.0;
    const iconSize = 88.0;
    const startOpacity = 0.3;
    const endOpacity = 1.0;
    const tapAndHoldText = 'TAP & HOLD';
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showGuide = false;
                });
              },
              onTapDown: (_) => widget.onLeftDown(),
              onTapUp: (_) => widget.onLeftUp(),
              onTapCancel: () => widget.onLeftUp(),
              child: Container(
                height: double.infinity,
                color: Colors.transparent,
                child: showGuide
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: bottomPadding,
                            left: edgePadding,
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.undo_rounded,
                                  size: iconSize,
                                  color: Colors.white70,
                                ),
                                Text(
                                  tapAndHoldText,
                                  style: TextStyle(color: colors.brandColor5),
                                ),
                              ],
                            )
                                .animate(
                                  autoPlay: true,
                                  onPlay: (controller) => controller.repeat(
                                    reverse: true,
                                  ),
                                )
                                .fade(
                                  begin: startOpacity,
                                  end: endOpacity,
                                  delay: const Duration(milliseconds: 1400),
                                  curve: Curves.easeOutExpo,
                                  duration: const Duration(
                                    milliseconds: 700,
                                  ),
                                ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showGuide = false;
                });
              },
              onTapDown: (_) => widget.onRightDown(),
              onTapUp: (_) => widget.onRightUp(),
              onTapCancel: () => widget.onRightUp(),
              child: Container(
                height: double.infinity,
                color: Colors.transparent,
                child: showGuide
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: bottomPadding,
                            right: edgePadding,
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.redo_rounded,
                                  size: iconSize,
                                  color: Colors.white70,
                                ),
                                Text(
                                  tapAndHoldText,
                                  style: TextStyle(color: colors.brandColor5),
                                ),
                              ],
                            )
                                .animate(
                                  autoPlay: true,
                                  delay: const Duration(milliseconds: 2100),
                                  onPlay: (controller) => controller.repeat(
                                    reverse: true,
                                  ),
                                )
                                .fade(
                                  begin: startOpacity,
                                  end: endOpacity,
                                  delay: const Duration(milliseconds: 1400),
                                  curve: Curves.easeOutExpo,
                                  duration: const Duration(
                                    milliseconds: 700,
                                  ),
                                ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
