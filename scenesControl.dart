import 'dart:io';

export 'scenesControl.dart';

/*Função para exibir o menu do jogo -  */
String menu(){
  stdout.writeln('                                  *_____________The Bill\'s Journey_____________*\n');
  var showMenu = '''
                                                New Game (new)
                                                Load (load)
                                                Help (help)
                 ''';
  print(showMenu);
  stdout.write("/> ");
  String op = stdin.readLineSync();
  
  return op; //retorna a opção lida e manda para a class game.
}




