import 'scene.dart'; //jogo -> cena -> objeto (pode estar associado ao inventario)
import 'inventory.dart';
import 'object.dart'  ;

export 'game.dart';

class game{
  var scenes = new List<int>(); //cria vetor para armazenar cenas, as quais são indexadas por id.
  int currentScene;

  game.cs(int currentScene){
    this.currentScene = currentScene;
  }

  //pelo que vi, se não tem nennhuma operação específica com o atributo, o get e set são implementados automaticamente. é só usar
}