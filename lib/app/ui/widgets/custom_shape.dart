import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    var height = size.height;
    var width = size.width;
    var heightOffset = height * 0.2;

    path.lineTo(
      0,
      height - heightOffset,
    );

    path.quadraticBezierTo(
      width * 0.5,
      120,
      width,
      height - heightOffset,
    );

    path.lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
