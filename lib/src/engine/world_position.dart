
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Offset;
import 'package:flutterapp01/src/engine/tile_position.dart';
//import 'package:flutterapp01/src/engine/geometry/geometry.dart' show Offset;

@immutable
class WorldPosition {
  final double x;
  final double y;

  const WorldPosition(this.x, this.y);

  static WorldPosition fromTilePosition(TilePosition tp) {
    assert(tileSize != null, 'init tileSize first');
    final t = tileSize;
    final x = t * tp.col + tp.relX;
    final y = t * tp.row + tp.relY;
    return WorldPosition(x, y);
  }

  static WorldPosition fromOffset(Offset offset) {
    return WorldPosition(offset.dx, offset.dy);
  }

  static double tileSize;

  TilePosition toTilePosition() {
    assert(tileSize != null, 'init tileSize first');
    final t = tileSize;
    final col = x ~/ t;
    final row = y ~/ t;
    final relX = x % t;
    final relY = y % t;
    return TilePosition(col, row, relX, relY);
  }

  Offset toOffset() {
    return Offset(x, y);
  }
}
