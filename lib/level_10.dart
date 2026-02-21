import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level10 extends StatefulWidget {
  const Level10({super.key});

  @override
  State<Level10> createState() => _Level10State();
}

class _Level10State extends State<Level10> {
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
                  TextWidget(label: "ВОПРОС 5/5", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(label: "ВЫБЕРИТЕ ЛИШНЕЕ", size: 20),
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
                    child: TextWidget(label: 'РАБОТА', size: 17),
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
                    child: TextWidget(label: 'НАЧАЛЬНИК', size: 17),
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
                    child: TextWidget(label: 'КОМПАНИЯ', size: 17),
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
                    child: TextWidget(label: 'СЕМЬЯ', size: 17),
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
