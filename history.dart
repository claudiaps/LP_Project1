import 'dart:io';
import 'dart:async';

export 'history.dart';

void printHistory(){
  var introduction = '''
                    Essa história conta sobre acasos da vida de um jovem estudante universitário chamado Bill.
                Ele, como todo universitário, passa por vários perrengues durante sua vida acadêmica: provas,
                trabalhos, vida longe da família, etc.
                    Bill estava repleto de provas e trabalhos, devido ao final do seu primeiro semestre na
                faculdade. Professores não paravam de passar novos trabalhos, os já existentes estavam
                atrasados, provas complicadas estavam chegando. Ele precisava ficar acordado...
                     ''';
  var moreIntro =    '''
                    Então, de madrugada, enquanto fazia uma maratona de estudos, resolveu recorrer ao café,
                já que não estava mais conseguindo se manter de olhos abertos. Teria apenas um problema:
                Bill não fazia ideia de como fazer café e, devido ao horário, não poderia ligar para sua
                mãe e perguntar. Recorreu então ao seu velho amigo Google.
                    Google lhe ensinou como fazer café: coloque o pó no filtro, ferva a água e a jogue por
                cima do pó. A questão principal era: ele não possuía um filtro de café. Resultado, como bom
                brasileiro que era, resolveu dar um “jeitinho”. Acabou pegando uma meia e usando no processo.
                Foi então que tudo aconteceu...
                     ''';
  var endIntro =     '''
                    Bill começou a ver algo roxo no fundo da meia, enquanto passava a água, estranhou, mas
                como nunca tinha feito café na vida, julgou ser normal. Essa coisa roxa começou a se expandir,
                emanar glitter para todos os lados e, de repente, o sugou para dentro do café.
                    Bill desmaiou e, quando acordou, teve dificuldade para reconhecer onde estava. Ainda era
                sua casa, mas estava toda em tons de rosa, roxo e azul claro, bastante psicodélico. Decidiu,
                então, explorar aquele novo mundo.
                     ''';

  stdout.writeln('                                  *_____________The Bill Journey_____________*\n');
  print(introduction);

  String op = showOptions(); //pesquisar p mudar este tipo, ver se tem um com abrangência menor que uma string. Não pode ser var, pois função não pode ser var

  if(op == 'S' || op == 's'){
    print(moreIntro);
    op = showOptions();

    if(op == 'S' || op == 's')
      print(endIntro);
    else if(op == 'N' || op == 'n')
      print('tchau');
    else
      print('bb, não vale essa letra');
  }
  else if(proceed == 'N' || proceed == 'n')
    print('Tchau, então');
  else
    print('Querido(a), esta letra não vale');
}

String showOptions(){
  stdout.writeln('Continuar? (S, para Sim/N, para Não)');
  String proceed = stdin.readLineSync();

  return proceed;
}