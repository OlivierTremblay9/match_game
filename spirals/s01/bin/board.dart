part of mane;


class Board {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int x = 0;
  int y = 0;
  int width;
  int height;
  int lengthMatches;
  int widthMatches;
  
  var matchTest=new List();

  Board(this.canvas,this.lengthMatches,this.widthMatches) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    matchTest.add(new Match(this, 1,1,lengthMatches,widthMatches,"vertical")); 
    matchTest.add(new Match(this, 1,1,lengthMatches,widthMatches,"horizontal"));
    matchTest.add(new Match(this, 1,1,lengthMatches,widthMatches,"vertical"));
    querySelector('#canvas').onMouseDown.listen(onMouseDown);
    querySelector('#coordinates_0').innerHtml="Coordonnnés:X=n/a , Y=n/a";
    querySelector('#coordinates_1').innerHtml="Coordonnnés dernier click:X=n/a , Y=n/a";
    querySelector('#canvas').onMouseMove.listen(onMouseMove);
    window.animationFrame.then(gameLoop);
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
    for(int i=25;i<height;i+=(lengthMatches~/2)){
      context.moveTo(0, i);  
      context.lineTo(650, i);
    }
    for(int i=25;i<width;i+=(lengthMatches~/2)){
          context.moveTo(i, 0);  
          context.lineTo(i, 350);
        }
    context.lineWidth = 1;
    context.strokeStyle = '#C3E8F7';
    context.stroke();
    // code for update coordinates on canvas test only to be removed from final code
    context.font = "bold 10px sans-serif";
    context.fillStyle = "red";
    context.fillText("("+x.toString()+","+y.toString()+")",x,y);
    // Display matches this code to be modified in future
    matchTest[0].draw(25,25);
    matchTest[1].draw(25,125);
    matchTest[2].draw(125,25);
  }
  
  void draw() {
    clear();
    border();
  }
  
  void onMouseDown(MouseEvent e) {
    int y = e.offset.y;
    int x = e.offset.x;
    querySelector('#coordinates_1').innerHtml="Coordonnnés dernier click: X= "+ x.toString() + ", Y=" + y.toString(); 
  }
  
  void onMouseMove(MouseEvent e) {
      y = e.offset.y;
      x = e.offset.x;
      querySelector('#coordinates_0').innerHtml="Coordonnés: X= "+ x.toString() + ", Y=" + y.toString();
      
    }
}

