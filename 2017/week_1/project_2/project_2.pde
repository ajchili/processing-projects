boolean isRunning = false;
PongGame game;

void setup() {
  size(600, 400);
  
  isRunning = true;
  thread("step");
  game = new PongGame();
  
  loop();
}

void draw() {
  background(0);
  
  game.draw();
}

void step() {
  int mil = 0;
  while(isRunning) {
    if (millis() % 50 == 0 && mil != millis() && millis() % 50 != 1) {
      mil = millis();
    }
  }
}

class PongGame {
 
  private int p1Score, p2Score;
  private PongPaddle p1Paddle, p2Paddle;
  private PongBall ball;
  private boolean isGameRunning = false;
  
  public PongGame() {
    
  }
  
  public void draw() {
    if (isGameRunning) {
      
    } else {
      fill(255);
      noStroke();
      textSize(20);
      textAlign(CENTER, CENTER);
      text("Please press 'space' to start a game", 10, 30);
    }
  }
  
  class PongPaddle {
    
    private int x, y;
    
    public PongPaddle(int type) {
      
    }
  }
  
  class PongBall {
    
    private int x, y;
    
    public PongBall() {
      
    }
  }
}