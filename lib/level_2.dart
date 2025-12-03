import 'package:dreamjob/text_widget.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level2 extends StatefulWidget {
  const Level2({super.key});

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> with SingleTickerProviderStateMixin {
  late final GameLevelController _gameLevelController = GameScope.of(context).gameLevelController;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);


    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              child: TextWidget(
                label: "ДЛЯ ПРОХОЖДЕНИЯ ТЕСТИРОВАНИЯ ВАМ МОЖЕТ ПОНАДОБИТЬСЯ УСТРОЙСТВО ВЫВОДА ЗВУКА",
                size: 25,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Icon(
                      Icons.headphones,
                      size: 100,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.speaker,
                      size: 100,
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 10),
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