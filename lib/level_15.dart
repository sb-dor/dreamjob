import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level15 extends StatefulWidget {
  const Level15({super.key});

  @override
  State<Level15> createState() => _Level15State();
}

class _Level15State extends State<Level15> {
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
                  TextWidget(label: "ВОПРОС 3/5", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(
                    label: "ПО ДОРОГЕ НА РАБОТУ ВЫ УВИДЕЛИ ПОПАВШУЮ ПОД МАШИНУ СОБАКУ",
                    size: 25,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _gameLevelController.addToScore(-1); // Wrong answer
                      _gameLevelController.nextLevel();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: TextWidget(label: 'НЕ ОБРАЩАТЬ ВНИМАНИЯ', size: 17),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _gameLevelController.addToScore(-1); // Wrong answer
                      _gameLevelController.nextLevel();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: TextWidget(label: 'ОПОЗДАТЬ НА РАБОТУ', size: 17),
                    ),
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
