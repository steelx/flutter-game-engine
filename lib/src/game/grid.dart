
import 'dart:ui' show Canvas, Offset, Size;

import 'package:flutter/material.dart' show Colors, Paint, PaintingStyle;

class Grid {

  final Paint _gridPaint;
  final double tileSize;

  Grid(this.tileSize)
      : _gridPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.2;

  void render(Canvas canvas, {Size size}) {
    final delta = tileSize;
    for (double col = 0.0; col < size.width; col += delta) {
      final p1 = Offset(col, 0), p2 = Offset(col, size.height);
      canvas.drawLine(p1, p2, _gridPaint);
    }
    for (double row = 0.0; row < size.height; row += delta) {
      final p1 = Offset(0, row), p2 = Offset(size.width, row);
      canvas.drawLine(p1, p2, _gridPaint);
    }
  }

  void update(double dt) {

  }
}