import 'dart:math' show pi;

import 'package:flutterapp01/src/engine/tile_position.dart';
import 'package:flutterapp01/src/levels/tilemap.dart';
import 'package:flutterapp01/src/models/game_model.dart';
import 'package:flutterapp01/src/models/player_model.dart';

GameModel createModel(Tilemap tilemap, double tileSize) {
  final rows = tilemap.nrows;
  final cols = tilemap.ncols;
  final center = tileSize / 2;

  PlayerModel player;

  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      final tile = tilemap.tiles[row * cols + col];
      if (tile == Tile.Player) {
        player = PlayerModel(
          tilePosition: TilePosition(col, row, center, center),
          angle: pi / 2,// 180 / 2 = 90deg
        );
      }
    }
  }

  return GameModel(player: player);
}
