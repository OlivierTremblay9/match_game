library mane;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'board.dart';
part 'model/match.dart';
part 'model/memory.dart';
part 'model/segment.dart';
part 'model/gameCtrl.dart';

void main() {
  // Get a reference to the canvas.
  CanvasElement canvas = querySelector('#canvas');
  ButtonElement play = querySelector('#play');
  ButtonElement solve = querySelector('#solve');
  play.onClick.listen(playAgain);
  //Board(canvas,lengthMatches,widthMatches,clearance,Button) 
  new Board(canvas,100,10,25,solve);
}

playAgain(Event e) {
  window.location.reload();
}
