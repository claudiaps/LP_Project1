export 'object.dart';

class Object{
  int idObject; //id do objeto
  int type; //tipo do objeto
  String objectName; //nome do objeto
  String objectDescription; //descricao do objeto
  String positiveResult; //resultado positivo
  String negativeResult; //resultado negativo
  String correctCommand; //comando correto
  int targetScene; //cena alvo: para saber a qual cena(s) pertence o objeto
  bool solved; //cena já resolvida?
  bool got; //objeto já obtido? (inventario)

  Object (this.idObject, this.type, this.objectName, this.objectDescription, this.positiveResult,this.negativeResult, this.correctCommand, this.targetScene, this.got, this.solved){

  }

}