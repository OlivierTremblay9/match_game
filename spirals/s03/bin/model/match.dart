part of mane;

class Match{
  Board board;
  num posX;
  num posY;
  int lenght;
  int width;
 // bool rightDown = false;
 // bool leftDown = false;
  String orientation;
  ImageElement matchImage_V;
  ImageElement matchImage_H;

  
  Match(this.board,this.posX,this.posY,this.lenght,this.width,this.orientation){
    //  document.onKeyDown.listen(_onKeyDown);
     // document.onKeyUp.listen(_onKeyUp); 
      matchImage_V = document.querySelector('#match_vertical');
      matchImage_H = document.querySelector('#match_horizontal');
  
  }
  

  
  draw(int x, int y) {
    
   // board.context.beginPath();
   // board.context.rect(posX, posY, lenght, width);
   // board.context.closePath();
    //board.context.fill();
    
    
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
  
 //_onKeyDown(event){
 //    if (event.keyCode == 39){
  //     rightDown = true;
   //  }
  //   else if (event.keyCode ==37){
   //    leftDown = true;
   //  }
   // }
   
  // _onKeyUp(event){
  //   if (event.keyCode == 39){
  //     rightDown = false;
  //   }
  //   else if (event.keyCode ==37){
   //    leftDown = false;
   //  }
   // }
  
  rotate(){
    if (orientation=="vertical"){
      orientation="horizontal";
    }      
    else{
      orientation="vertical";
    }              
  }
}