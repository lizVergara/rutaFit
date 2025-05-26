import 'package:flutter/material.dart';

class SignalPainter extends CustomPainter {
  final double progress;
  final Color color;
  SignalPainter({required this.progress, this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxR = size.width * .5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (int i = 0; i < 3; i++) {
      final radius = maxR * (progress + i / 3).clamp(0.0, 1.0);
      paint.color = color.withOpacity((1 - progress) * (.4 - i * .05));
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SignalPainter old) =>
      old.progress != progress || old.color != color;
}
