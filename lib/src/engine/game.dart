
import 'dart:ui' show Canvas, Size;
import 'package:flutter/material.dart' show debugPrint, mustCallSuper;

abstract class Game {
  void update(double dt);
  void render(Canvas canvas);

  @mustCallSuper
  void resize(Size size) {}

  @mustCallSuper
  void onAttach() {
    debugPrint('game attached');
  }

  @mustCallSuper
  void onDetach() {
    debugPrint('game dettached');
  }
}
