library mane;

import 'dart:html';
import 'dart:async';

part 'board.dart';
part 'model/match.dart';
part 'model/memory.dart';

void main() {
  // Get a reference to the canvas.
  CanvasElement canvas = querySelector('#canvas');
  ButtonElement play = querySelector('#play');
  play.onClick.listen(playAgain);
  //Board(canvas,lengthMatches,widthMatches) 
  new Board(canvas,100,10,25);
}

playAgain(Event e) {
  window.location.reload();
}
