import 'package:dreamjob/level_14.dart';
import 'package:dreamjob/level_14_1.dart';
import 'package:dreamjob/level_15.dart';
import 'package:dreamjob/score_screen.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:flutter/material.dart';

import 'level_1.dart';
import 'level_10.dart';
import 'level_11.dart';
import 'level_12.dart';
import 'level_13.dart';
import 'level_2.dart';
import 'level_3.dart';
import 'level_4.dart';
import 'level_5.dart';
import 'level_6.dart';
import 'level_7.dart';
import 'level_8.dart';
import 'level_8_1.dart';
import 'level_9.dart';

class GameLevelController with ChangeNotifier {
  late final SoundPlayer _soundPlayer;

  bool controllerInitialized = false, _loadingNextLevel = false;
  int _currentLevelIndex = 0;
  int _score = 0;
  bool _showScoreScreen = false;

  Widget get currentLevel {
    if (_showScoreScreen) {
      return ScoreScreen(score: _score);
    }
    return _levels[_currentLevelIndex];
  }

  final List<Widget> _levels = [
    Level1(),
    Level2(),
    Level3(),
    Level4(),
    Level5(),
    Level6(),
    Level7(),
    Level8(),
    Level81(),
    Level9(),
    Level10(),
    Level11(),
    Level12(),
    Level13(),
    Level14(),
    Level141(),
    Level15(),
  ];

  int get score => _score;

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

      // Check if we should show a score screen based on score threshold
      // For example, show score screen if score is greater than 5
      if (_score > 5 && !_showScoreScreen) {
        _showScoreScreen = true;
      } else {
        _currentLevelIndex++;
        _showScoreScreen = false; // Hide score screen when moving to next level
      }
    } catch (e) {
      print('Error in nextLevel: $e');
    } finally {
      _loadingNextLevel = false;
      notifyListeners();
    }
  }

  void addToScore(int points) {
    _score += points;
    print('Score updated: $_score'); // For debugging purposes
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    _showScoreScreen = false;
    notifyListeners();
  }

  void hideScoreScreen() {
    _showScoreScreen = false;
    notifyListeners();
  }
}
