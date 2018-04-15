/**
 * Start the Music (Linux with Sox Player):
 *  play -q ambiance.wav repeat 999 > /dev/null & dart main.dart && killall play
 */
import 'game.dart';

void main(){
  new Game();
}
