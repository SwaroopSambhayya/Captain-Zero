import 'dart:math';
import 'package:captain_zero/features/level1/components/recycle_bin.dart';
import 'package:captain_zero/features/level1/level1.dart';
import 'package:flame/components.dart';

class Trash extends SpriteComponent with HasGameRef<RecycleGame> {
  final RecycleBin recycleBin;
  final Vector2 gameSize;

  static final Random _random = Random();
  static const double speed = 250;
  static const double rotationSpeed = 3;
  static const List<String> trashImages = [
    'plastic.png',
    'bottle.png',
    'tin.png',
    'paper.png'
  ];

  Trash(this.gameSize, this.recycleBin) {
    size = Vector2.all(40);
    position = Vector2((_random.nextDouble() * (gameSize.x - size.x)) + 8, 0);
  }

  @override
  Future<void> onLoad() async {
    String randomTrashImages = trashImages[_random.nextInt(trashImages.length)];
    sprite = await gameRef.loadSprite(randomTrashImages);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // falling effect
    position.add(Vector2(0, speed * dt));

    // Rotate while falling
    angle += rotationSpeed * dt;
    anchor = Anchor.center;

    // Collision detection with the bin
    if (recycleBin.toRect().contains(position.toOffset())) {
      removeFromParent();
      gameRef.trashCollected++;
    }

    // Check if the trash is off the screen
    if (position.y > gameSize.y) {
      removeFromParent();
      gameRef.trashMissed++;
    }
  }
}
