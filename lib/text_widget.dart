import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.label, this.size = 14});

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Courier',
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: Colors.white.withValues(alpha: 0.8),
        shadows: const [
          Shadow(color: Colors.cyan, offset: Offset(-3, -3), blurRadius: 10),
          Shadow(color: Colors.red, offset: Offset(3, 3), blurRadius: 10),
        ],
        letterSpacing: 3,
      ),
    );
  }
}
