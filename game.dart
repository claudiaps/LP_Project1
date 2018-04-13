import 'scene.dart'; //jogo -> cena -> objeto (pode estar associado ao inventario)
import 'object.dart';
import 'dart:convert';
import 'dart:io';
// import 'package:args/args.dart';
// import 'history.dart';
import 'scenesControl.dart';
// import 'dart:async';

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
    var command = menu();
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
      if (command == 'new') {
        while (true) {
          var current = currentScene;
          play();
          while (current == currentScene) {
            read_line();
          }
        }
      }
    });
    if (command == 'load') {
      stdout.write("Digite o nome com a qual salvou o jogo que deseja retomar");
      stdout.write("/> ");
      String save = stdin.readLineSync();

      new File('saves/$save.json')
          .readAsString()
          .then((fileContents) => JSON.decode(fileContents))
          .then((jsonData) {
        currentScene = jsonData["cenaAtual"];
        inventory = jsonData["inventario"];
        var itens = new List();
        for (var object in jsonData["objetosCena"]) {
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
        while (true) {
          var current = currentScene;
          play();
          while (current == currentScene) {
            read_line();
          }
        }
      });
    } else if (command == 'help') {
      printHelp();
    }
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
    } else if (texto[0] == 'inventory') {
      inventory_command();
    } else if (texto[0] == 'save') {
      save_command();
    }
    if (texto.length == 2 || texto.length == 4) {
      if (texto[0] == 'get') {
        get_command(texto[1]);
      }
      if (texto[0] == 'check') {
        check_command(texto[1]);
      } else if (texto[0] == 'use') {
        if (texto.length == 2) {
          if (is_object(texto[1])) {
            use_command(texto[1]);
          } else {
            print(
                "\nObjeto inválido. Tente objetos da cenas, ou se desejar algum de seu inventário, consulte o mesmo com o comando INVENTORY\n");
          }
        } else if (texto.length == 4) {
          if (texto[2] == 'with') {
            if (is_inventory(texto[1]) && is_object(texto[3])) {
              use_with_command(texto[1], texto[3]);
            } else {
              print(
                  "Colega, os objetos não estão com o nome correto, ou não estão nessa cena / inventário. Tenta outra coisa");
            }
          } else {
            print(
                "Comado errado. Provavelmente não seguiu o padrão USE ______ WITH_____, ou o nome dos objetos estão errados");
          }
        }
      }
    }
  }

  play() {
    print(this.scenes[this.currentScene].description);
    return 0;
  }

  get_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        if (object.type == 1) {
          if (object.got == true) {
            print("\nItem já obtido querido\n");
            return;
          } else {
            inventory.add(item);
            object.got = true;
            print("\nItem $item adicionado ao inventário\n");
            return;
          }
        }
      }
    }
    print(
        "Não pode colocar esse objeto no inventário, ou esse obejto não existe. Tenta outro ai");
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
      }
    }
    return false;
  }

  is_inventory(String item) {
    for (var key in inventory) {
      if (item == key) {
        return true;
      }
    }
    return false;
  }

  use_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (object.objectName == item) {
        if (object.type == 0 && object.correctCommand == 'use $item') {
          print(object.positiveResult);
          object.solved = true;
          currentScene = object.targetScene;
        } else {
          print(object.negativeResult);
        }
      }
    }
  }

  inventory_command() {
    if (inventory.length == 0) {
      print("\nInventário vazio!");
    } else {
      print(inventory);
    }
  }

  use_with_command(String item, String scene_item) {
    for (var object in scenes[currentScene].objects) {
      if (object.objectName == scene_item && object.type == 0) {
        if (object.correctCommand == 'use $item with $scene_item') {
          object.solved = true;
          print(object.positiveResult);
          currentScene = object.targetScene;
          inventory.remove(item);
        } else {
          print("comando errado");
        }
      }
    }
  }

  save_command() {
    stdout.write("/> Digite o nome com a qual deseja salvar o jogo \n/>");
    String save_name = stdin.readLineSync();
    var save = new Map();
    save['cenaAtual'] = currentScene;
    save['inventario'] = inventory;
    var itensCena = [];

    for (var objeto in scenes[currentScene].objects) {
      var objetoJSON = {
        'idObject': objeto.idObject,
        'type': objeto.type,
        'objectName': objeto.objectName,
        'objectDescription': objeto.objectDescription,
        'positiveResult': objeto.positiveResult,
        'negativeResult': objeto.negativeResult,
        'correctCommand': objeto.correctCommand,
        'targetScene': objeto.targetScene,
        'solved': objeto.solved,
        'got': objeto.got
      };

      itensCena.add(objetoJSON);
    }
    save['objetosCena'] = itensCena;
    print(save);
    new File('saves/$save_name.json').writeAsStringSync(JSON.encode(save));
  }

  // command() {
  //   var command = menu();
  //   if (command == 'new') {
  //     initClass('test.json');
  //   } else if (command == 'load') {
  //     load_command();
  //   } else if (command == 'help') {
  //     printHelp();
  //   }
  // }

  printHelp() {
    print(
        "Para jogar Bill's Journey, basta associar os objetos das cenas com a cena. Ou objetos do seu inventário aos da cena.\nOs comandos são: \n  USE: Usar um objeto \n  GET: Colocar um objeto em seu inventário \n  DESCRIPTION: Descrição do objeto \n  USE ___ WITH ____: Usar um obejto do inventário com um da cena \n INVENTORY: exibir itens do inventário \n  EXIT: sair do jogo \n  SAVE: Salvar o jogo \n");
  }

  exit_game() {
    stdout.write("Deseja nos abandonar? Todo progresso não salvo será perdido");
    stdout.write("/> ");
    String get_out = stdin.readLineSync();
    if (get_out == "S" || get_out == 's') {
      print('Okay, até mais');
      exit(0);
    } else {
      return;
    }
  }
}
