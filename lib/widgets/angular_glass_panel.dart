import 'dart:ui';
import 'package:flutter/material.dart';


class AngularGlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AngularGlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(26),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: const _AngularClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.07),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _AngularBorderPainter()),
          ),
        ),
      ],
    );
  }
}

Path _angularPath(Size size) {
  const cut = 28.0;
  return Path()
    ..moveTo(cut, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height - cut)
    ..lineTo(size.width - cut, size.height)
    ..lineTo(0, size.height)
    ..lineTo(0, cut)
    ..close();
}

class _AngularClipper extends CustomClipper<Path> {
  const _AngularClipper();

  @override
  Path getClip(Size size) => _angularPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _AngularBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = _angularPath(size);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
