part of mane;

class Match{
  Board board;
  int posX;
  int posY;
  int lenght;
  int width;
  String orientation;
  ImageElement matchImage_V;
  ImageElement matchImage_H;
  
  Match(this.board,this.posX,this.posY,this.lenght,this.width,this.orientation){
      matchImage_V = document.querySelector('#match_vertical');
      matchImage_H = document.querySelector('#match_horizontal');
  }
  
  
  draw(int x, int y) {
    if (this.orientation=="vertical")
      board.context.drawImageToRect(matchImage_V, new Rectangle(x-width~/2, y+width~/2, width, lenght-width));
    else
      board.context.drawImageToRect(matchImage_H, new Rectangle(x+width~/2, y-width~/2,lenght-width, width));
    }

  bool intersects (int x, int y){
    if (orientation == "vertical"){
      if (x > (posX- width) && x < (posX + width)){
        if (y> (posY+ width~/2)  && y< (posY+lenght-width~/2)){
          return true;
        }
      }
    }
    else{
      if (x> (posX+ width~/2) && x< (posX +lenght- width~/2)){
        if(y> (posY- width)  && y< (posY+width)){
          return true;
        }
      }
    }
    return false;
  }  
  
  rotate(){
    if (orientation=="vertical"){
      orientation="horizontal";
    }      
    else{
      orientation="vertical";
    }              
  }
}