import 'dart:io';
// import 'dart:async';
import 'dart:convert';

import 'history.dart';
import 'scenesControl.dart';
import 'object.dart';
import 'inventory.dart';
import 'game.dart';

void main() {
  var game = new Game('test.json');
  printHistory();
  while (true) {
    game.read_line();
  }
}
