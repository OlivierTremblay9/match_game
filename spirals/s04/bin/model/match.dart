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

//Match game 2 -------------------------------------------------------------------------
class Match2{
  Board2 board2;
  Segment used1;
  Segment used2;
  int posX2;
  int posY2;
  int posDrawX2;
  int posDrawY2;
  int lenght;
  int width;
  String orientation;
  String orientationDraw2;
  ImageElement matchImage_V;
  ImageElement matchImage_H;

  
  Match2(this.board2,this.posX2,this.posY2,this.lenght,this.width,this.orientation,this.used1,this.used2){
      matchImage_V = document.querySelector('#match_vertical');
      matchImage_H = document.querySelector('#match_horizontal');
      posDrawX2=posX2;
      posDrawY2=posY2;
      orientationDraw2=orientation;
      used1.cellUsed=true;
      used2.cellUsed=true;
  }
  

  setPosDraw(int x, int y,String orient){
    posDrawX2=x;
    posDrawY2=y;
    orientationDraw2=orient;
  }
  
  setPosition(int x, int y){
    posX2=x;
    posY2=y;  
  }
  
  setOnSegments(Segment segment1,Segment segment2){
    used1=segment1; 
    used2=segment2;
    posX2=segment1.x_0;
    posY2=segment1.y_0;
    orientation=segment1.orientation();
    used1.cellUsed=true;
    //used1.match2=this;
    used2.cellUsed=true;
    //used2.match2=this;
    
  }
  
  draw() {
  
    
    if (this.orientationDraw2=="vertical")
      board2.context.drawImageToRect(matchImage_V, new Rectangle(posDrawX2-width~/2, posDrawY2+width~/2, width, lenght-width));
    else
      board2.context.drawImageToRect(matchImage_H, new Rectangle(posDrawX2+width~/2, posDrawY2-width~/2,lenght-width, width));
    
    }

  bool intersects (int x, int y){
    if (orientation == "vertical"){
      if (x > (posX2- width) && x < (posX2 + width)){
        if (y> (posY2+ width~/2)  && y< (posY2+lenght-width~/2)){
          return true;
        }
      }
    }
    else{
      if (x> (posX2+ width~/2) && x< (posX2 +lenght- width~/2)){
        if(y> (posY2- width)  && y< (posY2+width)){
          return true;
        }
      }
    }
    return false;
  }  
  

  
  rotate(){
    if (orientationDraw2=="vertical"){
      orientationDraw2="horizontal";
    }      
    else{
      orientationDraw2="vertical";
    }              
  }
}