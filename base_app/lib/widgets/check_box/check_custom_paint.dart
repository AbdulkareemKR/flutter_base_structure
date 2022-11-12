import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class CheckCustomPaint extends CustomPainter {
  double value1;
  double value2;
  double value3;
  double value4;
  Color color;
  CheckCustomPaint({
    this.color = Colors.black,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.08880200, size.height * 0.5227273);
    path_0.lineTo(size.width * value1, size.height * value2);
    path_0.lineTo(size.width * value3, size.height * value4);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_0_stroke.color = color;
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.stroke;

    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
