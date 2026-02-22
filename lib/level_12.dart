import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level12 extends StatefulWidget {
  const Level12({super.key});

  @override
  State<Level12> createState() => _Level12State();
}

class _Level12State extends State<Level12> {
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
                children: [TextWidget(label: "ТЕСТ НА ПРОФЕССИОНАЛЬНУЮ ПРИГОДНОСТЬ", size: 30)],
              ),
            ),
          ),
          const SizedBox(height: 100),
          GestureDetector(
            onTap: () {
              _gameLevelController.nextLevel();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.transparent),
              child: TextWidget(label: 'ПРОДОЛЖИТЬ', size: 17),
            ),
          ),
        ],
      ),
    );
  }
}
