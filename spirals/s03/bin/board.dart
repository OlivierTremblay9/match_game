part of mane;


class Board {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  ButtonElement solve;
  int x = 0;
  int y = 0;
  int width;
  int height;
  int lengthMatches;
  int widthMatches;
  int clearance;
  Match activeMatch=null;
  Memory gameSpace;
  int gameState;

  Board(this.canvas,this.lengthMatches,this.widthMatches,this.clearance,this.solve) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    gameSpace=new Memory(this);
    gameSpace.initGameStep(3);
    
    querySelector('#canvas').onMouseDown.listen(onMouseDown);
    querySelector('#info_0').innerHtml="Coordonnnés:X=n/a , Y=n/a";
    querySelector('#info_1').innerHtml="Vous avez ${gameSpace.displacements} disponibles";
    querySelector('#canvas').onMouseMove.listen(onMouseMove);
    window.onKeyDown.listen( onKeyDown); // Use onKeyDown instead of onKeyPress 
    window.animationFrame.then(gameLoop);
    solve.onClick.listen(solveGame);
  }

  
  void gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  void clear() {
    context.clearRect(0, 0, width, height);
    
  }

  void border() {
    var grd = context.createLinearGradient(0, 0, canvas.width, canvas.height);
    context.rect(0, 0, width, height);
    grd.addColorStop(0, '#D9D9D9');
    grd.addColorStop(1, '#D9D9D9');
    context.fillStyle = grd;
    context.fill();
    // grid drawing 
    for(int i=clearance;i<height;i+=(lengthMatches~/2)){
      context.moveTo(0, i);  
      context.lineTo(650, i);
    }
    for(int i=clearance;i<width;i+=(lengthMatches~/2)){
          context.moveTo(i, 0);  
          context.lineTo(i, 350);
        }
    context.lineWidth = 1;
    context.strokeStyle = '#C3E8F7';
    context.stroke();

    gameSpace.draw();
   
   
  }
  

  
  void draw() {
    clear();
    border();
  }
  
  
  void onMouseDown(MouseEvent e) {
    int x= e.offset.x;
    int y= e.offset.y;
    Segment nearest;
    gameState=0;
    String Message="Vous avez ${gameSpace.displacements} disponibles";
    if (activeMatch==null){
      activeMatch=gameSpace.verifyIfSelectedMatchclick(x,y);
    }
    else{
      nearest=gameSpace.nearestSegment(x, y);
      if(gameSpace.moveMatch(activeMatch, nearest)==false) {
        activeMatch.setPosDraw(activeMatch.posX,activeMatch.posY,activeMatch.orientation); 
      }        
      else{
        if (gameSpace.displacements==0){
            if (gameSpace.validate()==true){
              print('vous avez gagné!');
              gameState =1;
              Message='Vous avez gagné';
            }
            else{
              print('vous avez perdu!');
              gameState=2;
              Message='Vous avez perdu';
            }
        }
      }  
      activeMatch=null;
    }
    
    querySelector('#info_1').innerHtml=Message;
   
  }
  
  void onMouseMove(MouseEvent e) {
      y = e.offset.y;
      x = e.offset.x;
      Segment nearest;
      if (activeMatch!=null){
        nearest=gameSpace.nearestSegment(x, y);
        activeMatch.setPosDraw(nearest.x_0,nearest.y_0,nearest.orientation());
      }
      querySelector('#info_0').innerHtml="Coordonnés: X= "+ x.toString() + ", Y=" + y.toString();
      
    }
  
  
    
  void onKeyDown(KeyboardEvent e){
    print(e.keyCode);  
    
     if  ((activeMatch!=null)&&(e.keyCode == 32)) {
          print('pressed space');
          activeMatch.rotate();
    }
     
  }
  
  void solveGame(Event e){
    gameSpace.solve();
  }
}

