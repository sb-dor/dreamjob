import 'package:just_audio/just_audio.dart';

class SoundPlayer {
  final _player = AudioPlayer();

  // Вызывай эту функцию, когда нужно проиграть звук
  Future<void> play10SecSound() async {
    await _player.setAsset('assets/sounds/vhs_noice.mp3'); // или .wav, .ogg
    await _player.play();
  }

  // Если хочешь зациклить навсегда
  Future<void> playLoop() async {
    await _player.setVolume(20);
    await _player.setAsset('assets/sounds/vhs_noice.mp3');
    await _player.setLoopMode(LoopMode.one); // зациклит этот трек
    await _player.play();
  }

  // Остановить в любой момент
  Future<void> stop() async => await _player.stop();
}
