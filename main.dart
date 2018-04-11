import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'history.dart';
import 'scenesControl.dart';
import 'object.dart';
import 'game.dart';

// teste(game) => new Future((Game game) => {});

Future main() async {
  var game = await new Game();
  // game.initClass('test.json');
  //printHistory();
  // while (game.currentScene == null);
  // while (true) {
  //   game.play();
  // }
}
