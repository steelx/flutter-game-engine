import 'dart:ui' show Canvas, Color, Image, Offset, Paint, Rect;

//import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutterapp01/src/engine/images.dart';

class Sprite {
  final Paint _paint = Paint()..color = const Color(0xffffffff);
  Image image;
  double width, height;
  bool _loaded;

  Sprite(String pathToImg, {double width, double height}) {
    _loaded = false;
    Images.instance.load(pathToImg).then((img) {
      _sizeFromImage(img, width: width, height: height);
      _loaded = true;
    });
  }

  Sprite.fromImage(Image img, {double width, double height}) {
    _sizeFromImage(img, width: width, height: height);
    _loaded = true;
  }

  static Future<Sprite> fromPath(String pathToImg, {double width, double height}) async {
    final img = await Images.instance.load(pathToImg);
    return Sprite.fromImage(img, width: width, height: height);
  }

  void _sizeFromImage(Image img, {double width, double height}) {
    image = img;
    //??= means if its null then only set value
    // since {} curly brace params are optional
    this.width = width ?? image.width.toDouble();
    this.height = height ?? image.height.toDouble();
  }

  bool get hasLoaded => _loaded;

  void render(Canvas canvas, Offset position) {
    if (!hasLoaded) {
      return;
    }

    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(position.dx - width/2, position.dy - height/2, width, height);
    canvas.drawImageRect(image, src, dst, _paint);
  }
}
