import 'package:flutter/material.dart';

class CustomPainterClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height*0.0271429); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.40, 0);
    path.arcToPoint(Offset(size.width * 0.60, 10), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.59, 0, size.width * 0.65, 0);
    //path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width,size.height*0.0271429);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}