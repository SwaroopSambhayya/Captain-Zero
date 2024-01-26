import 'package:captain_zero/features/game/level1/game.dart';
import 'package:flame/components.dart';

class RecycleBin extends SpriteComponent with HasGameRef<RecycleGame> {
  double speed = 300;
  final Vector2 gameSize;

  RecycleBin(this.gameSize) {
    size = Vector2(100, 100);
    position = Vector2((gameSize.x - size.x) / 2, gameSize.y - size.y - 8);
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bin.png');
  }

  void moveLeft({required double dt}) {
    position.x = (position.x - speed * dt).clamp(0, gameSize.x - size.x);
  }

  void moveRight({required double dt}) {
    position.x = (position.x + speed * dt).clamp(0, gameSize.x - size.x);
  }
}
