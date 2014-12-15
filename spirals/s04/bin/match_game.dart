library mane;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'board.dart';
part 'model/match.dart';
part 'model/memory.dart';
part 'model/segment.dart';

void main() {
  // Get a reference to the canvas.
  CanvasElement canvas = querySelector('#canvas');
  CanvasElement canvas2 = querySelector('#canvas2');
  ButtonElement play = querySelector('#play');
  ButtonElement play2 = querySelector('#play2');
  ButtonElement solve = querySelector('#solve');
  ButtonElement solve2 = querySelector('#solve2');
  play.onClick.listen(playAgain);
  //Board(canvas,lengthMatches,widthMatches,clearance,Button) 
  new Board(canvas,100,10,25,solve);
  new Board2(canvas2,100,10,25,solve2);
}

playAgain(Event e) {
  window.location.reload();
}
