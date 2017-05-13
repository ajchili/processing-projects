PongGame game;

void setup() {
  size(600, 400);
  frameRate(60);
  
  game = new PongGame();
  
  loop();
}

void draw() {
  background(0);
  
  game.draw();
}

void keyPressed() {
  if (keyCode == 32) {
    game.startGame(); 
  }
}

void mouseMoved() {
  game.mouseMoved();
}

class PongGame {
 
  private int p1Score, p2Score;
  private int winner = -1;
  private PongPaddle p1Paddle, p2Paddle;
  private PongBall ball;
  private boolean isGameRunning = false;
  
  public PongGame() {
    p1Paddle = new PongPaddle(0);
    p2Paddle = new PongPaddle(1);
    ball = new PongBall();
  }
  
  public void draw() {
    if (isGameRunning) {
      drawScore();
      
      fill(162);
      for (int i = 0; i < 20; i++) {
        if (i % 2 == 1) {
          rect(295, -10 + i * 20, 10, 20);
        }
      }
     
      ball.draw();
      p1Paddle.draw();
      p2Paddle.draw();
    } else {
      fill(255);
      noStroke();
      textSize(20);
      textAlign(CENTER, CENTER);
      if (winner == -1) {
        text("Please press 'space' to start a game", 300, 200);
      } else {
        drawScore();
        textSize(20);
        textAlign(CENTER, CENTER);
        text("Player " + (winner + 1) + " has won!\nPress 'space' to start a new game", 300, 200);
      }
    }
  }
  
  public void mouseMoved() {
    p1Paddle.mouseMoved();
  }
  
  public void startGame() {
    if (!isGameRunning) {
      isGameRunning = true;
      p1Score = 0;
      p2Score = 0;
    }
  }
  
  public void drawScore() {
    fill(255);
    noStroke();
    textSize(30);
    textAlign(CENTER, TOP);
    text(p1Score, 150, 10);
    text(p2Score, 450, 10);
  }
  
  class PongPaddle {
    
    private int x, y, type;
    private final int WIDTH = 10;
    private final int HEIGHT = 60;
    
    public PongPaddle(int type) {
      this.type = type;
      if (this.type == 0) {
        x = 10;
      } else {
        x = 600;
      }
      y = 200;
    }
    
    public void draw() {
      if (type != 0 && ball != null) {
        if (ball.getY() + (HEIGHT / 4) >= y) {
          y++; 
        } else if (ball.getY() + (HEIGHT / 4) <= y) {
          y--; 
        }
      }
      
      fill(255);
      noStroke();
      rect(x - WIDTH, y - (HEIGHT / 2), WIDTH, HEIGHT);
    }
    
    public void mouseMoved() {
      if (type == 0) {
        if (mouseY < HEIGHT / 2) {
          y = HEIGHT / 2; 
        } else if (mouseY > 400 - (HEIGHT / 2)) {
          y = 400 - (HEIGHT / 2); 
        } else {
          y = mouseY; 
        }
      }
    }
    
    public int getX() {
      return x; 
    }
    
    public int getY() {
      return y; 
    }
  }
  
  class PongBall {
    
    private int x, y;
    private float xStep, yStep;
    private final int SIZE = 20;
    
    public PongBall() {
      x = 300;
      y = 200;
      generateMovement();
    }
    
    public void draw() {
      move();
      
      fill(255);
      noStroke();
      rect(x - (SIZE / 2), y - (SIZE / 2), SIZE, SIZE);
    }
    
    public void generateMovement() {
      if ((int) random(0, 100) < 50) {
        xStep = 2 + (random(0, 2) / (int) random(2, 2));
      } else {
        xStep = -2 - (random(0, 2) / (int) random(2, 2));
      }
      
      if ((int) random(0, 100) < 50) {
        yStep = 2 + (random(0, 2) / (int) random(2, 2));
      } else {
        yStep = -2 - (random(0, 2) / (int) random(2, 2));
      }
    }
    
    public void move() {
      if (x < -50) {
        p2Score++;
        if (p2Score == 9) {
          isGameRunning = false;
          winner = 1;
        }
        x = 300;
        y = 200;
        generateMovement();
      } else if (x > 650) {
        p1Score++;
        if (p1Score == 9) {
          isGameRunning = false;
          winner = 0;
        }
        x = 300;
        y = 200;
        generateMovement();
      }
      
      if (x - (SIZE / 2) <= 10 && x >= 0 || x + (SIZE / 2) >= 590 && x <= 600) {
        if (p1Paddle.getY() - 30 <= y + (SIZE / 2) && p1Paddle.getY() + 30 >= y - (SIZE / 2)) {
          xStep = abs(xStep);
        } else if (p2Paddle.getY() - 30 <= y + (SIZE / 2) && p2Paddle.getY() + 30 >= y - (SIZE / 2)) {
          xStep = abs(xStep) * -1;
        }
      }
      
      if (y - (SIZE / 2) <= 0) {
        yStep = abs(yStep);
      } else if (y + (SIZE / 2) >= 400) {
        yStep = abs(yStep) * -1;
      }
      x += xStep;
      y += yStep;
    }
    
    public int getX() {
      return x; 
    }
    
    public int getY() {
      return y; 
    }
  }
}