import 'dart:io';

export 'scenesControl.dart';
import 'game.dart';

String menu(){
  stdout.writeln('                                  *_____________The Bill\'s Journey_____________*\n');
  var showMenu = '''
                                                New Game (N)
                                                Load
                                                Help (H)
                 ''';
  print(showMenu);
  stdout.write("/> ");
  String op = stdin.readLineSync();
  
  return op;
}




