import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level18 extends StatefulWidget {
  const Level18({super.key});

  @override
  State<Level18> createState() => _Level18State();
}

class _Level18State extends State<Level18> {
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
                  TextWidget(label: "ПОСЛЕДНИЙ ТЕСТ. ТЕСТ НА СОВМЕСТИМОСТЬ С РАБОТОЙ.", size: 30),
                ],
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
