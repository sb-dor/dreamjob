import 'dart:math';
import 'package:dreamjob/game_level_controller.dart';
import 'package:dreamjob/sound_player.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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

class _RetroTVScreenState extends State<RetroTVScreen> with TickerProviderStateMixin {
  late final AnimationController _scanlineController;
  late final AnimationController _textController;
  late final AnimationController _vhsController;
  late final GameLevelController _gameLevelController;
  late final SoundPlayer _soundPlayer;

  String currentText = '';
  bool showContinueButton = false;

  int currentTextIndex = 0;

  @override
  void initState() {
    super.initState();

    _scanlineController = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _vhsController = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
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
    _scanlineController.dispose();
    _textController.dispose();
    _vhsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: Listenable.merge([_scanlineController, _vhsController]),
        builder: (context, child) {
          return Stack(
            children: [
              // Основной контент (фон + текст + кнопка)
              Positioned.fill(
                child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
              ),

              // Твой старый скан-линии
              CustomPaint(painter: ScanlinePainter(_scanlineController.value), size: Size.infinite),

              // Виньетка
              CustomPaint(painter: VignettePainter(), size: Size.infinite),

              // ←←←← НОВЫЙ VHS-ЭФФЕКТ ЗДЕСЬ
              CustomPaint(
                painter: VHSOverlayPainter(
                  time: _vhsController.value,
                  scanlineTime: _scanlineController.value,
                ),
                size: Size.infinite,
              ),

              ListenableBuilder(
                listenable: _gameLevelController,
                builder: (context, child) {
                  if(_gameLevelController.controllerInitialized) {
                    return _gameLevelController.currentLevel;
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

// Горизонтальные линии сканирования
class ScanlinePainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();

  // состояние линии
  static double? posY; // текущая позиция
  static double speed = 0; // скорость движения
  static double alpha = 0; // яркость
  static double thickness = 0; // толщина линии

  ScanlinePainter(this.animationValue) {
    // Если линии нет — шанс 1 к 40 создать новую
    if (posY == null && random.nextInt(40) == 0) {
      posY = random.nextDouble() * 0.1; // стартовая позиция
      speed = 2 + random.nextDouble() * 4; // 2–6 px per frame
      alpha = 0.1 + random.nextDouble() * 0.2; // прозрачность
      thickness = 6 + random.nextDouble() * 12; // толщина
    }

    // Если линия есть — движем вниз
    if (posY != null) {
      posY = posY! + speed / 1000; // скорость адаптирована к canvas высоте
      if (posY! > 1.2) {
        posY = null; // вышла за экран → удалить
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // обычные скан-линии
    final darkPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7)
      ..strokeWidth = 1;

    for (double i = 0; i < size.height; i += 3) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), darkPaint);
    }

    // если линии нет — выходим
    if (posY == null) return;

    // final y = posY! * size.height;

    // яркая бегущая линия
    // final flashPaint = Paint()
    //   ..color = Colors.white.withValues(alpha: alpha)
    //   ..strokeWidth = thickness;
    //
    // canvas.drawLine(
    //   Offset(0, y),
    //   Offset(size.width, y),
    //   flashPaint,
    // );
  }

  @override
  bool shouldRepaint(ScanlinePainter oldDelegate) => true;
}

// Виньетка
class VignettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = ui.Gradient.radial(
      Offset(size.width / 2, size.height / 2),
      size.width / 1.5,
      [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
      [0.5, 1.0],
    );

    final paint = Paint()..shader = gradient;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(VignettePainter oldDelegate) => false;
}

class VHSOverlayPainter extends CustomPainter {
  final double time;
  final double scanlineTime;
  final Random rnd = Random();

  VHSOverlayPainter({required this.time, required this.scanlineTime});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Дрожание (tracking error) — весь экран слегка трясётся
    final shakeX = (sin(time * 33) * 4).clamp(-4.0, 4.0);
    final shakeY = (sin(time * 27) * 2).clamp(-2.0, 2.0);
    canvas.translate(shakeX, shakeY);

    // 2. Полосы помех (горизонтальные белые линии)
    if (rnd.nextDouble() < 0.01) {
      final y = rnd.nextDouble() * h;
      final thickness = 2 + rnd.nextDouble() * 8;
      canvas.drawRect(
        Rect.fromLTWH(0, y, w, thickness),
        Paint()..color = Colors.white.withValues(alpha: 0.15 + rnd.nextDouble() * 0.2),
      );
    }

    // 3. Цветовые искажения (chromatic aberration) + размытие
    canvas.saveLayer(Rect.fromLTWH(0, 0, w, h), Paint());
    canvas.drawRect(
      Rect.fromLTWH(-6, 0, w, h),
      Paint()..color = Colors.red.withValues(alpha: 0.07),
    );
    canvas.drawRect(
      Rect.fromLTWH(6, 0, w, h),
      Paint()..color = Colors.cyan.withValues(alpha: 0.07),
    );
    canvas.restore();

    // 4. Плёночный шум
    for (int i = 0; i < 400; i++) {
      final x = rnd.nextDouble() * w;
      final y = rnd.nextDouble() * h;
      final opacity = rnd.nextDouble() * 0.06;
      canvas.drawCircle(
        Offset(x, y),
        0.8,
        Paint()..color = Colors.white.withValues(alpha: opacity),
      );
    }

    // 5. Лёгкое общее размытие и цветовой сдвиг (как на старой кассете)
    final blurPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.2);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), blurPaint);

    // 6. Иногда — сильная горизонтальная полоса (как при перемотке)
    if (rnd.nextDouble() < 0.015) {
      final y = rnd.nextDouble() * h;
      canvas.drawRect(
        Rect.fromLTWH(0, y - 40, w, 80),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.3)
          ..blendMode = BlendMode.plus,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
