import 'package:captain_zero/features/level1/components/recycle_bin.dart';
import 'package:captain_zero/features/level1/components/trash.dart';
import 'package:captain_zero/shared/components/help_dialog.dart';
import 'package:captain_zero/shared/components/level_App_bar.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  bool _isDialogShown = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showHelpDialog(context, 1);
      setState(() {
        _isDialogShown = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Trash Dash",
        leadingText: "Level 1",
        onActionPress: () {
          showHelpDialog(context, 1);
        },
        iconData: Icons.help,
      ),
      body: _isDialogShown
          ? GameWidget(
              game: RecycleGame(
                onGameEnd: () => context.go('/levelComplete/1'),
              ),
            )
          : Container(
              color: Colors.white,
            ),
    );
  }

  void showInfoDialog() {}
}

class RecycleGame extends FlameGame with PanDetector {
  final Function onGameEnd;
  RecycleGame({required this.onGameEnd});

  static const trashSpawnInterval = 0.6;
  int trashCollected = 0;
  int trashMissed = 0;

  late RecycleBin bin;
  late Timer trashSpawnTimer;
  late TextComponent collectedText;
  late TextComponent missedText;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.black,
    );
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //music
    FlameAudio.bgm.play('level1.mp3', volume: 0.2);
    // Create and add the recycle bin
    bin = RecycleBin(size);
    add(bin);
    // Timer for spawning trash
    trashSpawnTimer =
        Timer(trashSpawnInterval, repeat: true, onTick: spawnTrash);
    trashSpawnTimer.start();

    const textStyle = TextStyle(
      fontFamily: 'GillSans',
      fontSize: 24.0,
      color: Colors.white,
    );

    collectedText = TextComponent(
      text: "Collected: $trashCollected",
      position: Vector2(10, 20),
      textRenderer: TextPaint(style: textStyle),
    );

    missedText = TextComponent(
      text: "Missed: $trashMissed",
      position: Vector2(10, 60),
      textRenderer: TextPaint(style: textStyle),
    );
    add(collectedText);
    add(missedText);
  }

  void spawnTrash() {
    final trash = Trash(size, bin);
    add(trash);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (trashCollected >= 50) {
      FlameAudio.bgm.stop();
      onGameEnd();
    }
    trashSpawnTimer.update(dt);
    collectedText.text = "Collected: $trashCollected";
    missedText.text = "Missed: $trashMissed";
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    const movementIntensity = 0.04;
    if (info.delta.global.x < 0) {
      bin.moveLeft(dt: movementIntensity);
    } else if (info.delta.global.x > 0) {
      bin.moveRight(dt: movementIntensity);
    }
  }
}
