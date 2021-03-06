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
  GameCtrl gameCtrl;

  Board(this.canvas,this.lengthMatches,this.widthMatches,this.clearance,this.solve) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    gameSpace=new Memory(this);
    gameCtrl= new GameCtrl(this);
    
    querySelector('#canvas').onMouseDown.listen(onMouseDown);
    querySelector('#info_0').innerHtml="Coordonnnés:X=n/a , Y=n/a";
    querySelector('#info_1').innerHtml="Vous avez ${gameCtrl.numOfMovesAvailables} mouvements disponibles";
    querySelector('#canvas').onMouseMove.listen(onMouseMove);
    querySelector('#step').innerHtml="Jeu 1: Formez un carré parfait en déplaçant une allumette";
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
      context.lineTo(width, i);
    }
    for(int i=clearance;i<width;i+=(lengthMatches~/2)){
          context.moveTo(i, 0);  
          context.lineTo(i, height);
        }
    context.lineWidth = 1;
    context.strokeStyle = '#C3E8F7';
    context.stroke();

    gameSpace.draw();
   
   
  }
  

  
  void draw() {
    clear();
    border();
    if(gameCtrl.gameState==2 || gameCtrl.gameState==6 || gameCtrl.gameState==10){
      drawTextWin();
    }
    else{
      if(gameCtrl.gameState==1 || gameCtrl.gameState==5 || gameCtrl.gameState==9){
          drawTextLoose();
      } 
      else{
        if(gameCtrl.gameState==3 || gameCtrl.gameState==7 || gameCtrl.gameState==11){
          drawTextSolution();
        }
      }
    }
      
  }
  
  drawTextWin(){
    
    context.font = "bold 14px sans-serif";
    context.fillStyle = "green";
    context.fillText("Vous avez Gagné !! Cliquez Ici pour passer au suivante",125,400);    
  }
  
  drawTextLoose(){
    context.font = "bold 14px sans-serif";
    context.fillStyle = "red";
    context.fillText("Vous avez perdu !! Cliquez Ici pour essayer à nouveau",125,400);
  }
  
  drawTextSolution(){
    context.font = "bold 14px sans-serif";
    context.fillStyle = "blue";
    context.fillText("Voici la solution !! Cliquez Ici pour essayer de le faire",125,400);
    
  }
  
  void onMouseDown(MouseEvent e) {
    int x= e.offset.x;
    int y= e.offset.y;
    Segment nearest;
    String Message="Vous avez ${gameCtrl.numOfMovesAvailables} mouvements disponibles";
    
    if(gameCtrl.gameState==0 || gameCtrl.gameState==4 || gameCtrl.gameState==8){
      if (activeMatch==null){
            activeMatch=gameSpace.verifyIfSelectedMatchclick(x,y);
          }
      else{
            nearest=gameSpace.nearestSegment(x, y);
            if(gameSpace.moveMatch(activeMatch, nearest)==false) {
              activeMatch.setPosDraw(activeMatch.posX,activeMatch.posY,activeMatch.orientation); 
             }        
            else{
              gameCtrl.matchMovedOk();
            }
            activeMatch=null;
         }  
    }
    else{
      gameCtrl.nextStep();
    }
    
    if (gameCtrl.gameState==1 || gameCtrl.gameState==5 || gameCtrl.gameState==9){
        querySelector('#info_1').innerHtml= 'vous avez perdu';
    }
    if(gameCtrl.gameState==2 || gameCtrl.gameState==6 || gameCtrl.gameState==10){
       querySelector('#info_1').innerHtml='vous avez gagné';
    }
    if (gameCtrl.gameState==3 || gameCtrl.gameState==7 || gameCtrl.gameState==11){
        querySelector('#info_1').innerHtml='Solution Fourni !!';
    }
    if (gameCtrl.gameState==0 || gameCtrl.gameState==4 || gameCtrl.gameState==8) {
      querySelector('#info_1').innerHtml="Vous avez ${gameCtrl.numOfMovesAvailables} mouvements disponibles";
    }
    
    if (gameCtrl.gameState<4){
      querySelector('#step').innerHtml="Jeu 1: Formez un carré parfait en déplaçant une allumette";  
    }
    else{
      if(gameCtrl.gameState<8){
        querySelector('#step').innerHtml="Jeu 2: En bougeant 5 allumettes, formez 3 carrés de même taille";  
      }
      else{
        querySelector('#step').innerHtml="Jeu 3: Bougez une seule allumette pour passer de 5 à 6 carrés.";
      }
    }
    
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
    gameCtrl.solve();
  }
}

