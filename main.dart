import 'dart:io';
// import 'dart:async';
import 'dart:convert';

import 'history.dart';
import 'scenesControl.dart';
import 'object.dart';

void main(){

  //acessa o JSON
  new File('test.json')
    .readAsString()
    .then((fileContents) => JSON.decode(fileContents))
    .then((jsonData) {
       print(jsonData["teste"]); //acessar campo específico do JSON
    });

  String opMenu = menu();

  if(opMenu == 'N' || opMenu =='n')
    printHistory();
  else if(opMenu == 'H' || opMenu == 'h')
    print('Exibir Ajuda depois!');
  else
    print('Falha ao carregar jogo!');

  
}