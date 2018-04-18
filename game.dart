import 'dart:convert';
import 'dart:io';
import 'scene.dart';
import 'object.dart';
import 'scenesControl.dart';

export 'game.dart';

class Game {
  var scenes =
      new List(); //cria vetor para armazenar cenas, as quais são indexadas por id.
  int currentScene;
  var inventory = new List();

  /*Função para inicializar o jogo. Essa função passa o arquivo JSON para a classe*/
  Game() {
    initClass("test.json");
  }

  /*Função responsável por iniciar a classe. */
  initClass(String path) {
    initialPrint();
    String command = menu();
    while (command != 'new' && command != 'load') {
      if (command == 'help') {
        printHelp();
      } else {
        print(
            "\n Comando errado ou indisponível no momento, tente new, load ou help\n");
      }
      command =
          menu(); //Armazena a opção retornada da função "menu" do arquivo scenesControl
    }
    new File(path)
        .readAsString()
        .then((fileContents) => JSON.decode(
            fileContents)) //Lê o arquivo com as cenas do jogo e suas informações
        .then((jsonData) {
      currentScene = jsonData["current_scene"]; //Identifica a cena atual
      for (var scene in jsonData["scenes"]) {
        //Percorre cada cena
        var itens = new List();
        for (var object in scene["objects"]) {
          //Extrai os dados de cada objeto da cena em questão
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
        //Inicia um novo jogo
        printStory();
        while (true) {
          var current = currentScene;
          play();
          while (current == currentScene) {
            read_line();
          }
          if (currentScene == 13) {
            end_game();
          }
        }
      }
    });

    if (command == 'load') {
      //Lê um jogo previamente salvo
      stdout.write("Digite o nome do jogo salvo que deseja retomar:");
      stdout.write("/> ");
      String save = stdin.readLineSync();
      var file = new File('saves/$save.json');
      file
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
          if (currentScene == 13) {
            end_game();
          }
        }
      }).catchError((e) {
        print(
            "Arquivo com nome errado. Inicie o jogo de novo, e digite o nome do save correto");
        return;
      }); //Lê o arquivo com base no nome passado
    }
  }

  handleError() {
    print("Nome do arquivo incorreto!");
  }

/*Função que faz a verificação dos comandos passados pelo usuário*/
  read_line() {
    print('');
    stdout.write("\> ");
    String text = stdin.readLineSync();
    text = text.toLowerCase();
    var texto = new List();
    texto = text.split(" ");

    if (texto.length == 1) {
      if (texto[0] == 'help') {
        printHelp();
        return;
      } else if (texto[0] == 'exit') {
        exit_game();
        return;
      } else if (texto[0] == 'inventory') {
        inventory_command();
        return;
      } else if (texto[0] == 'save') {
        save_command();
        return;
      }
    }
    if (texto.length == 2 || texto.length == 4) {
      //Verifica se é "use OBJETO" ou "use OBJETO1 WITH OBJETO2"
      if (texto[0] == 'get') {
        get_command(texto[1]);
        return;
      }
      if (texto[0] == 'check') {
        check_command(texto[1]);
        return;
      } else if (texto[0] == 'use') {
        if (texto.length == 2) {
          if (is_object(texto[1])) {
            use_command(texto[1]);
            return;
          } else {
            print("Humm.. Não conheço esse objeto. Tente outro.");
            return;
          }
        } else if (texto.length == 4) {
          if (texto[2] == 'with') {
            if (is_inventory(texto[1]) && is_object(texto[3])) {
              use_with_command(texto[1], texto[3]);
              return;
            } else {
              print("Esses objetos estão estranhos... Tente novamente!");
              return;
            }
          } else {
            print("Comando incorreto");
            return;
          }
        }
      }
    }
    print('Comando errado, tente outro!');
  }

  /*Função para exibir a descrição da cena*/
  play() {
    print('');
    print(scenes[currentScene].description);
    return;
  }

  /*Função que controla a adição de determinado objeto ao inventário*/
  get_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        if (object.type == 1) {
          if (object.got == true) {
            print("\nItem já obtido\n");
            return;
          } else {
            inventory.add(item);
            object.got = true;
            print("$item adicionado ao inventário");
            return;
          }
        }
      }
    }
    print(
        "Desculpe, mas não da pra colocar esse objeto no inventário. Tenta de novo!");
  }

  /*Função para verificar se determinado objeto passado pelo usuário existe na cena*/
  check_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        // print("");
        print(object.objectDescription);
        // print("");
        return;
      }
    }
    print("\nOps! Este objeto não existe!\n");
  }

  /*Função auxiliar que verifica se um objeto está na cena*/
  is_object(String item) {
    for (var object in scenes[currentScene].objects) {
      if (item == object.objectName) {
        return true;
      }
    }
    return false;
  }

  /*Função auxiliar que verifica se um objeto já está no inventário*/
  is_inventory(String item) {
    for (var key in inventory) {
      if (item == key) {
        return true;
      }
    }
    return false;
  }

  /*Função que controla o uso de determinado objeto*/
  use_command(String item) {
    for (var object in scenes[currentScene].objects) {
      if (object.objectName == item) {
        if (object.type == 0 && object.correctCommand == 'use $item') {
          print(object.positiveResult);
          object.solved = true;
          currentScene = object.targetScene;
          return;
        } else {
          print(object.negativeResult);
          return;
        }
      }
    }
  }

  /*Função para mostrar o conteúdo do inventário*/
  inventory_command() {
    if (inventory.length == 0) {
      print("\nInventário vazio!");
    } else {
      print(inventory);
    }
  }

  /*Função que controla o uso de determinado objeto com outro objeto */
  use_with_command(String item, String scene_item) {
    for (var object in scenes[currentScene].objects) {
      if (object.objectName == scene_item && object.type == 0) {
        if (object.correctCommand == 'use $item with $scene_item') {
          object.solved = true;
          print(object.positiveResult);
          currentScene = object.targetScene;
          inventory.remove(item);
        } else {
          print(object.negativeResult);
        }
      }
    }
  }

  /*Função para salvar o jogo*/
  save_command() {
    stdout.write("/> Digite o nome com o qual deseja salvar o jogo: \n/>");
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
    // print(save);
    new File('saves/$save_name.json').writeAsStringSync(JSON.encode(save));
  }

  /*Função para exibir a ajuda*/
  printHelp() {
    print(
        "\nPara jogar Bill's Journey, basta associar os objetos certos com cada cena ou objetos do seu inventário com a cena.\nOs comandos para jogar são (não importa se as letras estão maiúsculo ou minúsculo): \n\n  USE: Usar um objeto \n  GET: Colocar um objeto em seu inventário \n  DESCRIPTION: Descrição do objeto \n  USE ___ WITH ____: Usar um objeto do inventário com um da cena \n  INVENTORY: Exibir itens do inventário \n  EXIT: Sair do jogo \n  SAVE: Salvar o jogo \n\nAo iniciar o jogo, você tem algumas opições: Iniciar um jogo novo (comando NEW) ou carregar um jogo já salvo (comando LOAD). A função de LOAD só está disponível no início do jogo");
  }

  /*Função que controla a desistência no jogo*/
  exit_game() {
    stdout.write(
        "Deseja mesmo sair agora? Todo progresso não salvo será perdido... (S) ou (N)");
    stdout.write("\n/> ");
    String get_out = stdin.readLineSync();
    if (get_out == "S" || get_out == 's') {
      print('Jogo encerrado.');
      exit(0);
    } else {
      return;
    }
  }

  printStory() {
    print(
        '\n Essa história conta sobre acasos da vida de um jovem estudante universitário chamado Bill. Ele, como todo universitário, passa por vários perrengues durante sua vida acadêmica: provas, trabalhos, vida longe da família, etc.  Bill estava repleto de provas e trabalhos, devido ao final do seu primeiro semestre na faculdade. Professores não paravam de passar novos trabalhos, os já existentes estavam atrasados, provas complicadas estavam chegando. Ele precisava ficar acordado...\n (aaaah pequeno detalhe. AS frases em parênteses são pensamentos do narrador, ou programador no caso. Vai que a ideia fica legal) \n\n');
  }

  end_game() {
    print("Obrigada por jogar e tentar entender a história!");
    exit(0);
  }
}
