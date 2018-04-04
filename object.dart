export 'object.dart';

class object{
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

  object.ints(int idObject, int type, int targetScene){
    this.idObject    = idObject;
    this.type        = type;
    this.targetScene = targetScene;
  }

  object.strings(String objectName, String objectDescription, String positiveResult, String negativeResult, String correctCommand){
    this.objectName        = objectName;
    this.objectDescription = objectDescription;
    this.positiveResult    = positiveResult;
    this.negativeResult    = negativeResult;
    this.correctCommand    = correctCommand;
  }

  object.bools(bool solved, bool got){
    this.solved = solved;
    this.got    = got;
  }
}