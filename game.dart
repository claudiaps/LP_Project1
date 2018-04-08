import 'scene.dart'; //jogo -> cena -> objeto (pode estar associado ao inventario)
import 'inventory.dart';
import 'object.dart';
import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'history.dart';
import 'scenesControl.dart';

export 'game.dart';

class Game {
  var scenes =
      new List(); //cria vetor para armazenar cenas, as quais são indexadas por id.
  int currentScene;
  var inventory = new Inventory();

  //function to inicialize the game. This one passs the JSON file to the class
  Game(String path) {
    new File(path)
        .readAsString()
        .then((fileContents) => JSON.decode(fileContents))
        .then((jsonData) {
      currentScene = jsonData["current_scene"];
      for (var scene in jsonData["scenes"]) {
        var itens = new List();
        for (var object in scene["objects"]) {
          itens.add(new Object(
              object["idObject"],
              object["type"],
              object["objectName"],
              object["objectDescription"],
              object["positiveResult"],
              object["negativeResult"],
              object["correctCommand"],
              object["targetScene"],
              object["got"],
              object["solved"]));
        }
        scenes.add(new Scene(
            scene["idScene"], scene["description"], itens, scene["title"]));
      }
    });
  }

  read_line() {
    stdout.write("\> ");
    String text = stdin.readLineSync();
    if (text == 'help') {
      printHelp();
    } else if (text == 'exit') {
      exit_game();
    }
  }
}
