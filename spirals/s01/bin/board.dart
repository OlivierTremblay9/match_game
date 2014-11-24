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
    context.rect(10,10,200,100);
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

    context.beginPath();
    context.fillStyle = 'lightBlue';
    context.rect(x, y, width, height);
    context.fillRect(x, y, width, height);
    context.closePath();
    context.stroke();
  }
  
  void draw() {
    clear();
    border();
  }
}