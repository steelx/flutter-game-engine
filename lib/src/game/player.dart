
import 'dart:ui' show Canvas, Offset;

import 'package:flutterapp01/src/engine/sprite.dart';
import 'package:flutterapp01/src/engine/world_position.dart';
import 'package:flutterapp01/src/models/game_model.dart';

class Player {
  Sprite playerSprite;
  GameModel gameModel;


  Player(double tileSize, this.gameModel) {
    playerSprite = new Sprite('assets/images/topdown-player-r.png', width: tileSize, height: tileSize);
  }

  void render(Canvas canvas) {
    final player = gameModel.player;
    final playerTilePos = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePos);

    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(player.angle);
    playerSprite.render(canvas, Offset.zero);
    canvas.restore();
  }

  void update(double dt) {
    gameModel.player.angle += dt;
  }

}