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

    final valleyWidth = indicatorSize + 12;
    final depth = 0.18;

    final path = Path()
      // top Left Corner
      ..moveTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..lineTo(
        loc * width - valleyWidth * 2 < 0 ? 0 : loc * width - valleyWidth * 2,
        0,
      )
      ..cubicTo(
        loc * width - valleyWidth < 0 ? 0 : loc * width - valleyWidth,
        0,
        loc * width - valleyWidth * 0.8 < 0 ? 0 : loc * width - valleyWidth * 0.8,
        size.height * depth, // Lower the curve to create a deeper valley
        loc * width,
        size.height * depth, // Lower the curve to create a deeper valley
      )
      ..cubicTo(
        loc * width + valleyWidth * 0.8 > width
            ? width
            : loc * width + valleyWidth * 0.8,
        size.height * depth,
        loc * width + valleyWidth > width ? width : loc * width + valleyWidth,
        0,
        loc * width + valleyWidth * 2 > width
            ? width
            : loc * width + valleyWidth * 2,
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

    // Adjust the circle position slightly upwards
    final circleYPosition = size.height * depth - indicatorSize * 2;

    // Draw the circle indicator
    canvas.drawCircle(
        Offset(loc * width, circleYPosition), indicatorSize, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
