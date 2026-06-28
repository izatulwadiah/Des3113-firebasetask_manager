import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';


class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF06070D), AppColors.background],
            ),
          ),
        ),
        const Positioned.fill(child: CustomPaint(painter: _StarFieldPainter())),
        Positioned(
          top: -90,
          right: -70,
          child: _GlowBlob(color: AppColors.primary.withOpacity(0.30)),
        ),
        Positioned(
          bottom: -110,
          left: -80,
          child: _GlowBlob(color: AppColors.accent.withOpacity(0.16)),
        ),
        child,
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  const _GlowBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Fixed seed so stars stay in the same place across rebuilds.
    final rnd = Random(7);
    final paint = Paint();
    for (int i = 0; i < 80; i++) {
      final dx = rnd.nextDouble() * size.width;
      final dy = rnd.nextDouble() * size.height;
      final radius = rnd.nextDouble() * 1.1 + 0.3;
      paint.color = Colors.white.withOpacity(rnd.nextDouble() * 0.5 + 0.12);
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
