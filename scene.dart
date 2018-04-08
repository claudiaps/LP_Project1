export 'scene.dart';

class Scene {
  int idScene; //id da cena
  String sceneTitle; //titulo da cena
  String description; //descricao da cena
  var objects = new List(); //vetor de objetos


  Scene(this.idScene, this.description, this.objects, this.sceneTitle) {}
}
