import 'package:just_audio/just_audio.dart';

class SoundPlayer {
  SoundPlayer(this._path) {
    _player = AudioPlayer();
  }

  Future<void> init() async => await _player.setAsset(_path);

  final String _path;

  late final AudioPlayer _player;

  // Вызывай эту функцию, когда нужно проиграть звук
  Future<void> play() async {
    await _player.setVolume(3);
    await _player.seek(Duration.zero);
    await _player.play();
  }

  // Если хочешь зациклить навсегда
  Future<void> playLoop() async {
    await _player.setVolume(3);
    await _player.setLoopMode(LoopMode.one); // зациклит этот трек
    await _player.play();
  }

  // Остановить в любой момент
  Future<void> stop() async => await _player.stop();

  Future<void> dispose() async => await _player.dispose();
}
