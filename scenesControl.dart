import 'dart:io';

export 'scenesControl.dart';

String menu(){
  stdout.writeln('                                  *_____________The Bill Journey_____________*\n');
  var showMenu = '''
                                                New Game (N)
                                                Load **arquivo** 
                                                Save **arquivo**
                                                Help (H)
                 ''';
  print(showMenu);
  String op = stdin.readLineSync();
  
  return op;
}