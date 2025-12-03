import 'package:dreamjob/level_1.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:flutter/material.dart';

import 'level_2.dart';

class GameLevelController with ChangeNotifier {
  late final SoundPlayer _soundPlayer;

  bool controllerInitialized = false, _loadingNextLevel = false;
  int _currentLevelIndex = 0;

  Widget get currentLevel => _levels[_currentLevelIndex];
  final List<Widget> _levels = [Level1(), Level2()];

  void initializeController() async {
    _soundPlayer = SoundPlayer("assets/sounds/cassette_engagement.mp3");
    await _soundPlayer.init();
    controllerInitialized = true;
    notifyListeners();
  }

  void nextLevel() async {
    if(_loadingNextLevel) return;
    _loadingNextLevel = true;
    await Future.delayed(const Duration(milliseconds: 500));
    await _soundPlayer.play();
    _currentLevelIndex++;
    _loadingNextLevel = false;
    notifyListeners();
  }
}
