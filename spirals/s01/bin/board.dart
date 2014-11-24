part of mane;

class Board {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int x = 0;
  int y = 0;
  num width;
  num height;

  Board(this.canvas) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
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
    grd.addColorStop(0, '#8ed6ff');
    grd.addColorStop(1, '#004cb3');
    context.fillStyle = grd;
    context.fillStyle = 'grd';
    context.fill();
    context.moveTo(0, 27); //point 1.1 
    context.lineTo(650, 27);//point 1.2 
    context.moveTo(0, 176); //point 2.1 
    context.lineTo(650, 176);//point 2.2
    context.moveTo(0, 325); //point 3.1 
    context.lineTo(650, 325);//point 3.2
    context.moveTo(27, 0); //point 4.1 
    context.lineTo(27, 352);//point 4.2
    context.moveTo(176, 0); //point 8.1 
    context.lineTo(176, 352);//point 8.2
    context.moveTo(325, 0); //point 5.1 
    context.lineTo(325, 352);//point 5.2
    context.moveTo(474, 0); //point 6.1 
    context.lineTo(474, 352);//point 6.2
    context.moveTo(623, 0); //point 7.1 
    context.lineTo(623, 352);//point 7.2
    context.lineWidth = 2;
    context.strokeStyle = 'black';
    context.stroke();
  }
  
  void draw() {
    clear();
    border();
  }
}

