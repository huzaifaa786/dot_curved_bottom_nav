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
    final valleyWidth = indicatorSize + 20; // Keeps the valley wide
    final depth = 0.3; // Keeps the curve deep

    final path = Path()
      // top Left Corner
      ..moveTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..lineTo(loc * width - valleyWidth * 2, 0)
      ..cubicTo(
        loc * width - valleyWidth, // Move the curve start point closer to the center
        0,
        loc * width - valleyWidth * 0.8,
        size.height * depth, // Lower the curve to create a deeper valley
        loc * width,
        size.height * depth, // Lower the curve to create a deeper valley
      )
      ..cubicTo(
        loc * width + valleyWidth * 0.8,
        size.height * depth,
        loc * width + valleyWidth,
        0,
        loc * width + valleyWidth * 2, // Move the curve end point closer to the center
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

    // Draw the background path
    canvas.drawPath(path, paint);

    // Adjust the circle position slightly upwards
    final circleYPosition = size.height * depth - indicatorSize / 2;

    // Draw the circle indicator
    canvas.drawCircle(
        Offset(loc * width, circleYPosition), indicatorSize, circlePaint);

    // Create a transparent overlap effect at the first and last item
    final transparentPath = Path()
      ..moveTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    final transparentPaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;

    // Subtract the overlap areas from the path to create transparency
    canvas.drawPath(transparentPath, transparentPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
