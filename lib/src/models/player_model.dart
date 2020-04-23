import 'package:flutter/cupertino.dart';
import 'package:flutterapp01/src/engine/tile_position.dart';

class PlayerModel {
  final TilePosition tilePosition;
  final double angle;

  PlayerModel({@required this.tilePosition, this.angle});

  @override
  String toString() {
    return '''PlayerModel{
      tilePosition: $tilePosition
      angle: $angle
    }''';
  }
}