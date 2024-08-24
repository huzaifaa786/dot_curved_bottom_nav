import 'package:flutter/material.dart';

class CurvedNavPainter extends CustomPainter {
  Color color;
  late double loc;
  TextDirection textDirection;
  final double indicatorSize;

  final Color indicatorColor;
  double borderRadius;

  CurvedNavPainter({
    required double startingLoc,
    required int itemsLength,
    required this.color,
    required this.textDirection,
    this.indicatorColor = Colors.lightBlue,
    this.indicatorSize = 5,
    this.borderRadius = 25,
  }) {
    loc = 1.0 / itemsLength * (startingLoc + 0.48);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final circlePaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    final height = size.height;
    final width = size.width;

    const s = 0.1;
    const depth = 0.16;
    final valleyWidth = indicatorSize + 5;

    final path = Path()
      // top Left Corner
      ..moveTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..lineTo(loc * width - valleyWidth * 2, 0)
      ..cubicTo(
        (loc + s * 0.25) * size.width - valleyWidth,
        size.height * 0.15,  // Adjusted for more curve
        loc * size.width - valleyWidth,
        size.height * depth,
        (loc + s * 0.5) * size.width - valleyWidth,
        size.height * depth,
      )
      ..cubicTo(
        (loc + s * 0.25) * size.width + valleyWidth,
        size.height * depth,
        loc * size.width + valleyWidth,
        size.height * 0.15,  // Adjusted for more curve
        (loc + s * 0.75) * size.width + valleyWidth,
        0,
      )

      // top right corner
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(width, 0, width, borderRadius)

      // bottom right corner
      ..lineTo(width, height - borderRadius)
      ..quadraticBezierTo(width, height, width - borderRadius, height)

      // bottom left corner
      ..lineTo(borderRadius, height)
      ..quadraticBezierTo(0, height, 0, height - borderRadius)
      ..close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(
        Offset(loc * width, indicatorSize), indicatorSize, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
