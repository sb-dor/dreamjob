import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level7 extends StatefulWidget {
  const Level7({super.key});

  @override
  State<Level7> createState() => _Level7State();
}

class _Level7State extends State<Level7> {
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
                  TextWidget(label: "ВОПРОС 2/5", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(
                    label: "ЕСЛИ ВСЕ КОТЫ СЕРОГО ЦВЕТА, ТО ЖИВОТНОЕ СЕРОГО ЦВЕТА - ЭТО КОТ?",
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _gameLevelController.addToScore(-1); // Wrong answer
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: 'ДА', size: 17),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _gameLevelController.addToScore(2); // Correct answer
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: 'НЕТ', size: 17),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _gameLevelController.addToScore(-1); // Wrong answer
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: 'МОЖЕТ БЫТЬ', size: 17),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _gameLevelController.addToScore(-1); // Wrong answer
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: 'НЕВОЗМОЖНО ОПРЕДЕЛИТЬ', size: 17),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
