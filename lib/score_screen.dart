import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key, required this.score});

  final int score;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late final GameLevelController _gameLevelController = GameScope.of(context).gameLevelController;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  TextWidget(label: "ВАШ РЕЗУЛЬТАТ", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(label: "Очки: ${widget.score}", size: 25),
                  const SizedBox(height: 50),
                  TextWidget(label: "ПРОДОЛЖИТЬ", size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          GestureDetector(
            onTap: () {
              _gameLevelController.hideScoreScreen();
              _gameLevelController.nextLevel();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.transparent),
              child: TextWidget(label: 'ДАЛЕЕ', size: 17),
            ),
          ),
        ],
      ),
    );
  }
}
