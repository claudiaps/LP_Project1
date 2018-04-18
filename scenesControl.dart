import 'dart:io';

export 'scenesControl.dart';

/*Função para exibir o menu do jogo -  */
String menu() {
  stdout.write("/> ");
  String op = stdin.readLineSync();
  op = op.toLowerCase();

  return op; //retorna a opção lida e manda para a class game.
}

String initialPrint() {
  stdout.writeln(
      '                                  *_____________The Bill\'s Journey_____________*\n');
  var showMenu = '''
                                                New Game (new)
                                                Load (load)
                                                Help (help)
                 ''';
  print(showMenu);
}
