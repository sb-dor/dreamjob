import 'package:dreamjob/generated/assets.dart';
import 'package:dreamjob/vhs_overlay_painter.dart';
import 'package:flutter/material.dart';

import 'game_level_controller.dart';
import 'main.dart';

class Level191 extends StatefulWidget {
  const Level191({super.key});

  @override
  State<Level191> createState() => _Level191State();
}

class _Level191State extends State<Level191> {
  late final GameLevelController _gameLevelController = GameScope.of(context).gameLevelController;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _gameLevelController.nextLevel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: VhsOverlayPainter(background: Image.asset(fit: BoxFit.cover, Assets.imagesRottenMeat)),
    );
  }
}
