import 'package:flutter/material.dart';

class PasswordRulesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.14, size.height * 0.92);
    path.cubicTo(size.width * 0.14, size.height * 0.92, size.width * 0.26, size.height * 0.92, size.width * 0.26, size.height * 0.92);
    path.cubicTo(size.width * 0.26, size.height * 0.92, size.width / 5, size.height, size.width / 5, size.height);
    path.cubicTo(size.width / 5, size.height, size.width * 0.14, size.height * 0.92, size.width * 0.14, size.height * 0.92);
    path.lineTo(size.width * 0.07, size.height * 0.92);
    path.cubicTo(size.width * 0.03, size.height * 0.92, 0, size.height * 0.88, 0, size.height * 0.83);
    path.cubicTo(0, size.height * 0.83, 0, size.height * 0.09, 0, size.height * 0.09);
    path.cubicTo(0, size.height * 0.04, size.width * 0.03, 0, size.width * 0.07, 0);
    path.cubicTo(size.width * 0.07, 0, size.width * 0.93, 0, size.width * 0.93, 0);
    path.cubicTo(size.width * 0.97, 0, size.width, size.height * 0.04, size.width, size.height * 0.09);
    path.cubicTo(size.width, size.height * 0.09, size.width, size.height * 0.83, size.width, size.height * 0.83);
    path.cubicTo(size.width, size.height * 0.88, size.width * 0.97, size.height * 0.92, size.width * 0.93, size.height * 0.92);
    path.cubicTo(size.width * 0.93, size.height * 0.92, size.width * 0.07, size.height * 0.92, size.width * 0.07, size.height * 0.92);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
