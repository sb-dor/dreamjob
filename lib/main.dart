import 'dart:math';
import 'package:dreamjob/sound_player.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const RetroTVGameApp());
}

class RetroTVGameApp extends StatelessWidget {
  const RetroTVGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dreamjob',
      theme: ThemeData.dark(),
      home: const RetroTVScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RetroTVScreen extends StatefulWidget {
  const RetroTVScreen({super.key});

  @override
  State<RetroTVScreen> createState() => _RetroTVScreenState();
}

class _RetroTVScreenState extends State<RetroTVScreen> with TickerProviderStateMixin {
  late AnimationController _scanlineController;
  late AnimationController _textController;
  late AnimationController _vhsController; // ← новый контроллер для VHS
  late final SoundPlayer _soundPlayer;
  late final SoundPlayer _casseteEngagement;

  String currentText = '';
  bool showContinueButton = false;

  final List<String> gameTexts = [
    'ДАЛЬШЕ ВОПРОСЫ БУДЕТ\nЗАДАВАТЬ ТЕЛЕФОННЫЙРОБОТ',
    'ВНИМАНИЕ!НАЧИНАЕМ ТРАНСЛЯЦИЮ',
    'СИСТЕМА ЗАГРУЖАЕТСЯ...',
    'СВЯЗЬ УСТАНОВЛЕНА',
  ];

  int currentTextIndex = 0;

  @override
  void initState() {
    super.initState();

    _scanlineController = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _vhsController = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat(); // VHS-шум

    _showNextText();
    _initSounds();
  }

  void _initSounds() async {
    _soundPlayer = SoundPlayer('assets/sounds/vhs-noise.mp3');
    _casseteEngagement = SoundPlayer('assets/sounds/cassette_engagement.mp3');
    await _soundPlayer.init();
    await _casseteEngagement.init();
    _soundPlayer.playLoop();
  }

  void _showNextText() {
    setState(() {
      currentText = gameTexts[currentTextIndex];
      showContinueButton = true;
    });
    _textController.forward(from: 0);
  }

  void _onContinue() {
    _casseteEngagement.play();
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _textController,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          currentText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.95),
                            shadows: const [
                              Shadow(color: Colors.cyan, offset: Offset(-3, 0), blurRadius: 10),
                              Shadow(color: Colors.red, offset: Offset(3, 0), blurRadius: 10),
                            ],
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    if (showContinueButton)
                      GestureDetector(
                        onTap: _onContinue,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70, width: 3),
                            boxShadow: const [BoxShadow(color: Colors.white30, blurRadius: 20)],
                          ),
                          child: const Text(
                            'ПРОДОЛЖИТЬ',
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
      ..color = Colors.black.withOpacity(0.7)
      ..strokeWidth = 1;

    for (double i = 0; i < size.height; i += 3) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), darkPaint);
    }

    // если линии нет — выходим
    if (posY == null) return;

    final y = posY! * size.height;

    // яркая бегущая линия
    // final flashPaint = Paint()
    //   ..color = Colors.white.withOpacity(alpha)
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
        Paint()..color = Colors.white.withOpacity(0.15 + rnd.nextDouble() * 0.2),
      );
    }

    // 3. Цветовые искажения (chromatic aberration) + размытие
    canvas.saveLayer(Rect.fromLTWH(0, 0, w, h), Paint());
    canvas.drawRect(Rect.fromLTWH(-6, 0, w, h), Paint()..color = Colors.red.withOpacity(0.07));
    canvas.drawRect(Rect.fromLTWH(6, 0, w, h), Paint()..color = Colors.cyan.withOpacity(0.07));
    canvas.restore();

    // 4. Плёночный шум
    for (int i = 0; i < 400; i++) {
      final x = rnd.nextDouble() * w;
      final y = rnd.nextDouble() * h;
      final opacity = rnd.nextDouble() * 0.06;
      canvas.drawCircle(Offset(x, y), 0.8, Paint()..color = Colors.white.withOpacity(opacity));
    }

    // 5. Лёгкое общее размытие и цветовой сдвиг (как на старой кассете)
    final blurPaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.2);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), blurPaint);

    // 6. Иногда — сильная горизонтальная полоса (как при перемотке)
    if (rnd.nextDouble() < 0.015) {
      final y = rnd.nextDouble() * h;
      canvas.drawRect(
        Rect.fromLTWH(0, y - 40, w, 80),
        Paint()
          ..color = Colors.white.withOpacity(0.3)
          ..blendMode = BlendMode.plus,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
