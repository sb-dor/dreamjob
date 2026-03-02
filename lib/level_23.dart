import 'package:dreamjob/text_widget.dart';
import 'package:dreamjob/widget_screamer.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level23 extends StatefulWidget {
  const Level23({super.key});

  @override
  State<Level23> createState() => _Level23State();
}

class _Level23State extends State<Level23> {
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
                  TextWidget(label: "ВАМ ВАЖНА ВАША ВНЕШНОСТЬ? ВЫ БОИТЕСЬ ИЗМЕНИТЬСЯ", size: 25),
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
                      WidgetScreamer.show(
                        context,
                        asset: 'assets/images/freak_1.jpg',
                        duration: Duration(milliseconds: 500),
                      );
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
                      // Show the WidgetScreamer with the freak_1 image
                      WidgetScreamer.show(
                        context,
                        asset: 'assets/images/freak_1.jpg',
                        duration: Duration(milliseconds: 500),
                      );
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
