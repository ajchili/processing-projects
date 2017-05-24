ArrayList<Integer> pos = new ArrayList<Integer>();
ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Ball> ballsToRemove = new ArrayList<Ball>();
color background = color((int) random(0, 255), (int)random(0, 255), (int)random(0, 255));

void setup() {
  size(640, 480);
  frameRate(60);
  noStroke();
  loop();
}

void draw() {
  background(background);
  
  if (millis() % 1000 <= 25) background = color((int) random(0, 255), (int)random(0, 255), (int)random(0, 255));
  
  for (int i = 0; i < pos.size(); i++) {
    balls.add(new Ball(pos.get(i)));
  }
  
  pos.clear();
  
  for (Ball ball : balls) {
    ball.draw();
  }
  
  for (Ball ball : ballsToRemove) {
    balls.remove(ball); 
  }
  
  ballsToRemove.clear();
}

void mouseMoved() {
  pos.add(mouseX);
}

class Ball {
  
  private int x, y;
  private float pos = -11;
  private float momentum = pow(pos / 2, 2);
  private color c = color((int) random(0, 255), (int)random(0, 255), (int)random(0, 255));
  
  public Ball(int x) {
    this.x = x;
    this.y = 550;
    move();
  }
  
  void draw() {
    fill(c);
    ellipse(x, y, 10, 10);
    move();
  }
  
  private void move() {
    y += momentum;
    
    momentum = pos < 0 ? -pow(pos / 2, 2) : pow(pos / 2, 2);
    pos += .25;
    
    if (y > 600) {
      ballsToRemove.add(this); 
    }
  }
}