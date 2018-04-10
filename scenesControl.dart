import 'dart:io';

export 'scenesControl.dart';
import 'game.dart';

String menu(){
  stdout.writeln('                                  *_____________The Bill\'s Journey_____________*\n');
  var showMenu = '''
                                                New Game (N)
                                                Load **arquivo** 
                                                Save **arquivo**
                                                Help (H)
                 ''';
  print(showMenu);
  stdout.write("/> ");
  String op = stdin.readLineSync();
  
  return op;
}


printHelp() {
  print(
      "Para jogar Bill's Journey, basta associar os objetos das cenas com a cena. Ou objetos do seu inventário aos da cena.\nOs comandos são: \n  USE: Usar um objeto \n  GET: Colocar um objeto em seu inventário \n  DESCRIPTION: Descrição do objeto \n  USE ___ WITH ____: Usar um obejto do inventário com um da cena \n  EXIT: sair do jogo \n  SAVE: Salvar o jogo \n");
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

