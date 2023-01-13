import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0,size.height*0.0271429);
    path.lineTo(0,size.height);
    path.lineTo(size.width,size.height);
    path.lineTo(size.width,size.height*0.0271429);
    path.quadraticBezierTo(size.width*0.7964583,size.height*0.0321429,size.width*0.7083333,size.height*0.0314286);
    path.cubicTo(size.width*0.6287500,size.height*0.1289286,size.width*0.5666667,size.height*0.5735714,size.width*0.5025000,size.height*0.4728571);
    path.cubicTo(size.width*0.4339583,size.height*0.5835714,size.width*0.3677083,size.height*0.1292857,size.width*0.3325000,size.height*0.1442857);
    path.quadraticBezierTo(size.width*0.3406250,size.height*0.0300000,size.width*0.1008333,size.height*0.0285714);
    path.lineTo(0,size.height*0.0271429);

    canvas.drawShadow(path, Colors.black, 20, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}