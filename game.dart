import 'scene.dart'; //jogo -> cena -> objeto (pode estar associado ao inventario)
import 'object.dart';
import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'history.dart';
import 'scenesControl.dart';
import 'dart:async';

export 'game.dart';

class Game {
  var scenes =
      new List(); //cria vetor para armazenar cenas, as quais são indexadas por id.
  int currentScene;
  var inventory = new List();

  //function to inicialize the game. This one passs the JSON file to the class
  Game() {
    initClass("test.json");
  }

  initClass(String path) {
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
      while (true) {
        play();
        read_line();
      }
    });
  }

  read_line() {
    stdout.write("\> ");
    var texto = new List();
    String text = stdin.readLineSync();
    texto = text.split(" ");

    if (texto[0] == 'help') {
      printHelp();
    } else if (texto[0] == 'exit') {
      exit_game();
    } else if (texto[0] == 'get') {
      get_command(texto[1]);
    } else if (texto[0] == 'check') {
      check_command(texto[1]);
    } else if (texto[0] == 'use') {
      if (is_object(texto[1])) {
        use_command(texto[1]);
        // if (texto[2] == 'with') {
        //   use_with_command(texto[1], texto[3]);
        // } else if (texto[2] == null) {
        //   use_command(texto[1]);
        // }
      }
    }
  }

  play() {
    print(this.scenes[this.currentScene].description);
    return 0;
  }

  get_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName && object.type == 1) {
        if (object.got == true) {
          print("\nItem já obtido querido\n");
        } else {
          inventory.add(item);
          object.got = true;
          print("\nItem $item adicionado ao inventário\n");
        }
      } else {
        print("\nSorry migo, tu não pode colocar esse trem no inventário\n");
      }
    }
  }

  check_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        print("");
        print(object.objectDescription);
        print("");
      } else {
        print("\nMigo, não tem esse item ae não\n");
      }
    }
  }

  is_object(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        return true;
      } else {
        return false;
      }
    }
  }

  use_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (object.type == 0 && object.correctCommand == 'use $item') {
        print(object.positiveResult);
        object.solved = true;
        currentScene = object.targetScene;
      } else {
        print(object.negativeResult);
      }
    }
  }

  use_with_command(String item, String scene_item) {}
}
