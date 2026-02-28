import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level22 extends StatefulWidget {
  const Level22({super.key});

  @override
  State<Level22> createState() => _Level22State();
}

class _Level22State extends State<Level22> {
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
                  TextWidget(label: "ВОПРОС 4/5", size: 30),
                  const SizedBox(height: 50),
                  TextWidget(
                    label: "СПОКОЙНО ЛИ ВЫ ОТНОСИТЕСЬ К ВИДУ ЧЕЛОВЕЧЕСКИХ ОРГАНОВ?",
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
                      _gameLevelController.nextLevel();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: TextWidget(label: 'ДА', size: 17),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _gameLevelController.nextLevel();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: TextWidget(label: 'НЕТ', size: 17),
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
