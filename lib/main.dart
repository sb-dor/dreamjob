import 'package:dreamjob/game_level_controller.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:dreamjob/vhs_overlay_painter.dart';
import 'package:flutter/material.dart';

import 'generated/assets.dart';

void main() {
  runApp(const DreamJob());
}

class GameScope extends InheritedWidget {
  const GameScope({super.key, required this.state, required super.child});

  static DreamJobState of(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<GameScope>()?.widget;
    assert(widget != null, "GameScope was not found in element tree");
    assert(widget is GameScope, "GameScope was not found in element tree");
    return (widget as GameScope).state;
  }

  final DreamJobState state;

  @override
  bool updateShouldNotify(GameScope old) {
    return false;
  }
}

class DreamJob extends StatefulWidget {
  const DreamJob({super.key});

  @override
  State<DreamJob> createState() => DreamJobState();
}

class DreamJobState extends State<DreamJob> {
  final GameLevelController gameLevelController = GameLevelController();

  @override
  void initState() {
    super.initState();
    gameLevelController.initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return GameScope(
      state: this,
      child: MaterialApp(
        title: 'Dreamjob',
        theme: ThemeData.dark(),
        home: const RetroTVScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class RetroTVScreen extends StatefulWidget {
  const RetroTVScreen({super.key});

  @override
  State<RetroTVScreen> createState() => _RetroTVScreenState();
}

class _RetroTVScreenState extends State<RetroTVScreen> {
  late final GameLevelController _gameLevelController;
  late final SoundPlayer _soundPlayer;

  String currentText = '';
  bool showContinueButton = false;

  int currentTextIndex = 0;

  @override
  void initState() {
    super.initState();

    _gameLevelController = GameScope.of(context).gameLevelController;

    _initSounds();
  }

  void _initSounds() async {
    _soundPlayer = SoundPlayer('assets/sounds/vhs-noise.mp3');
    await _soundPlayer.init();
    await _soundPlayer.playLoop();
  }

  @override
  void dispose() {
    _soundPlayer.dispose();
    _gameLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VhsOverlayPainter(
        background: Image.asset(Assets.imagesBackground, fit: BoxFit.cover),
        builder: (context) => ListenableBuilder(
          listenable: _gameLevelController,
          builder: (context, child) {
            if (_gameLevelController.controllerInitialized) {
              return _gameLevelController.currentLevel;
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
