import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';

class Ch2 extends PositionComponent {
  static final Random _random = Random();
  late Timer disappearTimer;

  Ch2(Vector2 gameSize) {
    size = Vector2(50, 50); // Size of Ch2
    position = Vector2(_random.nextDouble() * (gameSize.x - size.x), 10);
    disappearTimer =
        Timer(2.0, onTick: () => removeFromParent()); // Adjust time as needed
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    disappearTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    disappearTimer.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw Ch2 as a rectangle
    canvas.drawRect(size.toRect(), Paint()..color = const Color(0xFF0000FF));
  }
}
