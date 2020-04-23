import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' show Image, decodeImageFromList;

import 'package:flutter/services.dart';

class Images {
  //create singleton
  static final _instance = new Images();
  static Images get instance => _instance;


  final loadedImagesMap = Map<String, Image>();

  Future<List<Image>> loadAll(List<String> paths) {
    final loaders = paths.map(load);
    return Future.wait(loaders);
  }

  Future<Image> load(String pathToImg) async {
    if (!loadedImagesMap.containsKey(pathToImg)) {
      final img = await _fetchFromMemory(pathToImg);
      loadedImagesMap[pathToImg] = img;
    }

    return loadedImagesMap[pathToImg];
  }

  Future<Image> _fetchFromMemory(String pathToImg) async {
    final data = await rootBundle.load(pathToImg);
    final imgBytes = Uint8List.view(data.buffer);
    final completr = new Completer<Image>();
    decodeImageFromList(imgBytes, (img) => completr.complete(img));
    return completr.future;
  }

}
