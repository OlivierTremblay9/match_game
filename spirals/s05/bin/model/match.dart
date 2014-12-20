part of mane;

class Match{
  Board board;
  Segment used1;
  Segment used2;
  int posX;
  int posY;
  int posDrawX;
  int posDrawY;
  int lenght;
  int width;
  String orientation;
  String orientationDraw;
  ImageElement matchImage_V;
  ImageElement matchImage_H;

  
  Match(this.board,this.posX,this.posY,this.lenght,this.width,this.orientation,this.used1,this.used2){
      matchImage_V = document.querySelector('#match_vertical');
      matchImage_H = document.querySelector('#match_horizontal');
      posDrawX=posX;
      posDrawY=posY;
      orientationDraw=orientation;
      used1.cellUsed=true;
      used2.cellUsed=true;
  }
  

  setPosDraw(int x, int y,String orient){
    posDrawX=x;
    posDrawY=y;
    orientationDraw=orient;
  }
  
  setPosition(int x, int y){
    posX=x;
    posY=y;  
  }
  
  setOnSegments(Segment segment1,Segment segment2){
    used1=segment1; 
    used2=segment2;
    posX=segment1.x_0;
    posY=segment1.y_0;
    orientation=segment1.orientation();
    used1.cellUsed=true;
    used1.match=this;
    used2.cellUsed=true;
    used2.match=this;
    
  }
  
  draw() {
  
    
    if (this.orientationDraw=="vertical")
      board.context.drawImageToRect(matchImage_V, new Rectangle(posDrawX-width~/2, posDrawY+width~/2, width, lenght-width));
    else
      board.context.drawImageToRect(matchImage_H, new Rectangle(posDrawX+width~/2, posDrawY-width~/2,lenght-width, width));
    
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
    if (orientationDraw=="vertical"){
      orientationDraw="horizontal";
    }      
    else{
      orientationDraw="vertical";
    }              
  }
}