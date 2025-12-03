import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level6 extends StatefulWidget {
  const Level6({super.key});

  @override
  State<Level6> createState() => _Level6State();
}

class _Level6State extends State<Level6> {
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
                  TextWidget(label: "ВОПРОС 1/5", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(label: "1 . . 2 . . 3 . . 4 . . ?", size: 25),
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
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: '1', size: 17),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: '10', size: 17),
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
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: '15', size: 17),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _gameLevelController.nextLevel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: TextWidget(label: '5', size: 17),
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
