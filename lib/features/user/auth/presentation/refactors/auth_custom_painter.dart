import 'package:flutter/material.dart';

class AuthCustomPainter extends CustomPainter {
  AuthCustomPainter({required this.gradient, super.repaint});

  final LinearGradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final path = Path();
    _pathChoeses(path, size);

    canvas.drawPath(path, paint);
  }

  void _pathChoeses(Path path, Size size) {
    path
      ..moveTo(size.width * -0.0345067, size.height * 0.6583005)
      ..lineTo(size.width * 1.0372800, size.height * 1.0012192)
      ..lineTo(size.width * 1.0394667, size.height * 1.0054064)
      ..lineTo(size.width * -0.0378133, size.height * 0.9998645);
  }

  @override
  bool shouldRepaint(covariant AuthCustomPainter oldDelegate) {
    return oldDelegate.gradient != gradient;
  }
}
