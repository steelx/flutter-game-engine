import 'package:flutter/material.dart';
import 'package:flutterapp01/src/engine/game_widget.dart';
import 'package:flutterapp01/src/engine/images.dart';
import 'package:flutterapp01/src/engine/world_position.dart';
import 'package:flutterapp01/src/game/game_setup.dart';
import 'package:flutterapp01/src/levels/levels.dart';
import 'package:flutterapp01/src/levels/tilemap.dart';
import 'package:flutterapp01/src/models/create_model.dart';
import 'package:flutterapp01/src/models/game_model.dart';
import 'package:flutterapp01/src/shared/game_props.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Images.instance.loadAll(['assets/images/topdown-player-r.png']);

  final tilemap = Tilemap.build(Levels.simple);
  WorldPosition.tileSize = GameProps.tileSize;
  final GameModel gameMap = createModel(tilemap, WorldPosition.tileSize);

  debugPrint('$tilemap');
  debugPrint('$gameMap');
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('welcome to heaven')),
      body: Container(
        color: Colors.amber,
        child: GameWidget(GameSetup(gameMap)),
      ),
    ),
  ));
}
