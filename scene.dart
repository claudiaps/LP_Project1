export 'scene.dart';

class scene{
  int idScene; //id da cena
  String sceneTitle; //titulo da cena
  String description; //descricao da cena
  var objects = new List<String>(); //vetor de objetos

  scene.id(int idScene){
    this.idScene = idScene;
  }

  scene.ds(String description){
    this.description = description;
  }

  scene.st(String sceneTitle){
    this.sceneTitle = sceneTitle;
  }
}