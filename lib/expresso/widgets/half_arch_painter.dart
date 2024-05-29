part of '../pages/pages.dart';

class HalfArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.03030303, size.height);
    path_0.lineTo(size.width * 0.03030303, size.height);
    path_0.cubicTo(
        size.width * 0.03030303,
        size.height * 0.4937392,
        size.width * 0.1795415,
        size.height * 0.08333333,
        size.width * 0.3636364,
        size.height * 0.08333333);
    path_0.lineTo(size.width * 0.6363636, size.height * 0.08333333);
    path_0.cubicTo(
        size.width * 0.8204576,
        size.height * 0.08333333,
        size.width * 0.9696970,
        size.height * 0.4937392,
        size.width * 0.9696970,
        size.height);
    path_0.lineTo(size.width * 0.9696970, size.height);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path_0, paint_0_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
