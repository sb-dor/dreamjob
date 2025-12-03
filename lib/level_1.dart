import 'package:dreamjob/game_level_controller.dart';
import 'package:dreamjob/main.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  late final GameLevelController _gameLevelController;

  @override
  void initState() {
    super.initState();
    _gameLevelController = GameScope.of(context).gameLevelController;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextWidget(label: "ВНИМАНИЕ", size: 40),
          ),
          const SizedBox(height: 200),
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
