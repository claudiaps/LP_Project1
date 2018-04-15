/**
 * Start the Music (Linux with Sox Player):
 *  nohup play ambiance.wav repeat 999 > /dev/null & dart main.dart && play -q stop.wav trim 0 2
 * play -q ambiance.wav repeat 999 > /dev/null & dart main.dart && play -q stop.wav trim 0 2
 * Ainda não funciona o parar a música, tem que matar o processo.
 */
import 'game.dart';

void main(){
  new Game();
}
