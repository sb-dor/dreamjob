import 'package:dreamjob/sound_player.dart';
import 'package:dreamjob/vhs_overlay_painter.dart';
import 'package:flutter/material.dart';

class WidgetScreamer extends StatefulWidget {
  const WidgetScreamer({
    super.key,
    required this.asset,
    this.duration = const Duration(milliseconds: 1500),
  });

  final String asset;
  final Duration duration;

  static Future<void> show(
    BuildContext context, {
    required final String asset,
    final Duration duration = const Duration(milliseconds: 1500),
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            WidgetScreamer(asset: asset, duration: duration),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  State<WidgetScreamer> createState() => _WidgetScreamerState();
}

class _WidgetScreamerState extends State<WidgetScreamer> {
  late final SoundPlayer _soundPlayer;

  @override
  void initState() {
    super.initState();

    // Initialize the sound player with a scream sound asset
    _soundPlayer = SoundPlayer('assets/sounds/cassette_engagement.mp3');
    _soundPlayer.init().then((_) {
      // Play the sound when the widget is initialized
      _soundPlayer.play();

      // Schedule to dispose and pop the screen after the specified duration
      Future.delayed(widget.duration, () {
        Future.delayed(const Duration(seconds: 3), () => _soundPlayer.dispose());
        if (mounted) {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: VhsOverlayPainter(background: Image.asset(fit: BoxFit.cover, widget.asset)),
    );
  }
}
