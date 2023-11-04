// Flutter imports:
import 'package:flutter/material.dart';

class HexagonContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;

  const HexagonContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HexagonPainter(color: color, height: height, width: width),
      child: child,
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  final double height;
  final double width;

  HexagonPainter({
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Path path = Path()
      ..moveTo(5, 0)
      ..lineTo(width - 5, 0)
      ..lineTo(width, height / 2)
      ..lineTo(width - 5, height)
      ..lineTo(5, height)
      ..lineTo(0, height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
