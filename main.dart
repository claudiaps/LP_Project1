//import 'dart:io';
//import 'dart:async';

import 'history.dart';
import 'scenesControl.dart';

void main(){
  String opMenu = menu();

  if(opMenu == 'N' || opMenu =='n')
    printHistory();
  else if(opMenu == 'H' || opMenu == 'h')
    print('Exibir Ajuda depois!');
  else
    print('Falha ao carregar jogo!');
}