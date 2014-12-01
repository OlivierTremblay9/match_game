part of mane;

class Match{
  Board board;
  int posX;
  int posY;
  int lenght;
  int width;
  String orientation;
  ImageElement matchImage;
  
  Match(this.board,this.posX,this.posY,this.lenght,this.width,this.orientation){
    if (this.orientation=="vertical")
      matchImage = document.querySelector('#match_vertical');
    else
      matchImage = document.querySelector('#match_horizontal');
  }
  
  
  draw(int x, int y) {
    if (this.orientation=="vertical")
      board.context.drawImageToRect(matchImage, new Rectangle(x-width~/2, y+width~/2, width, lenght-width));
    else
      board.context.drawImageToRect(matchImage, new Rectangle(x+width~/2, y-width~/2,lenght-width, width));
    }
  
  
}