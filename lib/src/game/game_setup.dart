import 'dart:ui' show Canvas, Size;

import 'package:flutterapp01/src/engine/game.dart';
import 'package:flutterapp01/src/game/grid.dart';
import 'package:flutterapp01/src/game/player.dart';
import 'package:flutterapp01/src/models/game_model.dart';
import 'package:flutterapp01/src/shared/game_props.dart';

class GameSetup extends Game {
  final GameModel gameModel;
  Size size;
  Player player;
  final Grid grid = Grid(GameProps.tileSize);

  GameSetup(this.gameModel) : player = Player(GameProps.tileSize, gameModel);

  @override
  void render(Canvas canvas) {
    _bottomLeftCanvas(canvas, size.height);
    grid.render(canvas, size: size);
    player.render(canvas);
  }

  @override
  void resize(Size size) {
    this.size = size;
    super.resize(size);
  }

  @override
  void update(double dt) {
    player.update(dt);
  }

  _bottomLeftCanvas(Canvas canvas, double height) {
    canvas.translate(0, height);
    canvas.scale(1, -1);
  }

}
