import 'package:dreamjob/level_1.dart';
import 'package:dreamjob/level_3.dart';
import 'package:dreamjob/level_4.dart';
import 'package:dreamjob/level_5.dart';
import 'package:dreamjob/level_6.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:flutter/material.dart';

import 'level_2.dart';

class GameLevelController with ChangeNotifier {
  late final SoundPlayer _soundPlayer;

  bool controllerInitialized = false, _loadingNextLevel = false;
  int _currentLevelIndex = 0;

  // Widget get currentLevel => _levels[_currentLevelIndex];
  Widget get currentLevel => _levels[_levels.length - 1]; // test
  final List<Widget> _levels = [Level1(), Level2(), Level3(), Level4(), Level5(), Level6()];

  void initializeController() async {
    _soundPlayer = SoundPlayer("assets/sounds/cassette_engagement.mp3");
    await _soundPlayer.init();
    controllerInitialized = true;
    notifyListeners();
  }

  void nextLevel() async {
    if (_currentLevelIndex + 1 >= _levels.length) return;
    if (_loadingNextLevel) return;

    _loadingNextLevel = true;

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await _soundPlayer.play();
      _currentLevelIndex++;
    } catch (e) {
      print('Error in nextLevel: $e');
    } finally {
      _loadingNextLevel = false;
      notifyListeners();
    }
  }
}
