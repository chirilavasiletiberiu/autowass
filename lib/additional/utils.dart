import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'dart:math';

class RedCircle extends CustomPainter {
  Paint _paint;

  RedCircle() {
    _paint = Paint()
      ..color = Color.fromRGBO(132, 7, 0, 1)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 16.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

const chars = "abcdefghijklmnopqrstuvwxyz";

String RandomString(int strlen) {
  Random rnd = new Random();

  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

const priceChars = "123456789";

String RandomPriceString(int strlen) {
  Random rnd = new Random();

  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += priceChars[rnd.nextInt(priceChars.length)];
  }
  return result;
}
