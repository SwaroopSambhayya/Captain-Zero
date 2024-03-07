import 'package:captain_zero/features/level3/const.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioHelper {
  bool isPaused = false;
  bool _audioEnabled = true;

  void setAudioEnabled(bool enabled) {
    _audioEnabled = enabled;
  }

  void pauseBackgroundMusic() {
    if (!FlameAudio.bgm.isPlaying) {
      return;
    }
    FlameAudio.bgm.pause();
    isPaused = true;
  }

  void stopMusic() {
    if (!FlameAudio.bgm.isPlaying) {
      return;
    }
    FlameAudio.bgm.stop();
    isPaused = true;
  }

  void resumeBackgroundMusic() async {
    if (!(_audioEnabled)) {
      return;
    }
    if (isPaused) {
      FlameAudio.bgm.resume();
    } else {
      playBackgroundMusic();
    }
    isPaused = false;
  }

  void playBackgroundMusic() async {
    if (!(_audioEnabled)) {
      return;
    }
    FlameAudio.bgm.play(
      'background.mp3',
      volume: Level3Constants.bgVolume,
    );
  }

  void playGameOverMusic() async {
    if (!_audioEnabled) {
      return;
    }
    FlameAudio.bgm.stop();

    FlameAudio.play('gameover.mp3', volume: Level3Constants.bgVolume);
  }

  void playVictorySound() async {
    if (!_audioEnabled) {
      return;
    }
    FlameAudio.play(
      'victory.mp3',
      volume: Level3Constants.bgVolume,
    );
  }
}
