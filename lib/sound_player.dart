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
    await _player.setVolume(1.0); // Volume должен быть от 0.0 до 1.0
    await _player.seek(Duration.zero); // Начать с начала
    await _player.play();
    // wait until the sound has completed
    await _player.playerStateStream.firstWhere(
      (state) => state.processingState == ProcessingState.completed,
    );
  }

  Future<void> seekTo(Duration duration) async {
    await _player.seek(duration);
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
