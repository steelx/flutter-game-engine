
import 'package:flutterapp01/src/models/player_model.dart';

class GameModel {
  final PlayerModel player;

  GameModel({this.player});

  @override
  String toString() {
    return '''PlayerModel{
      player: $player
    }''';
  }
}
