import 'dart:async';
import 'package:captain_zero/features/level3/components/save_the_earth.dart';
import 'package:captain_zero/features/level3/providers/audio_provider.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

class PlayPause extends PositionComponent
    with HasGameRef<SaveTheEarth>, RiverpodComponentMixin {
  PlayPause({required double size, required super.position})
      : super(size: Vector2.all(size), priority: 2);

  late SMIBool play;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final playPauseBoard = await loadArtboard(
      RiveFile.asset('assets/rive/play_pause.riv'),
    );
    final controller =
        StateMachineController.fromArtboard(playPauseBoard, 'State Machine 1')!;
    playPauseBoard.addController(controller);
    play = controller.findInput<bool>('Play') as SMIBool;
    play.change(!play.value);
    add(
      ButtonComponent(
        onPressed: () {
          play.change(!play.value);
          Future.delayed(const Duration(milliseconds: 800), () {
            if (game.paused) {
              game.resumeEngine();
              ref.read(audioProvider).resumeBackgroundMusic();
            } else {
              game.pauseEngine();
              ref.read(audioProvider).pauseBackgroundMusic();
            }
          });
        },
        button: RiveComponent(
          priority: 100,
          artboard: playPauseBoard,
          size: size,
        ),
      ),
    );
  }
}
