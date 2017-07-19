Block[] topSoil = new Block[64];
Block[][] ground;

int groundLevel;

void setup() { 
  size(640, 480);
  frameRate(60);
  noStroke();
  loop();
  
  generate();
}

void draw() {
  for (Block block : topSoil) {
    block.draw();
    ground[block.getX()][block.getY()] = null;
  }
  
  for (int i = 0; i < 64; i++) {
    for (int j = groundLevel; j < 48; j++) {
      if (ground[i][j] != null) ground[i][j].draw();
    }
  }
}

void keyPressed() {
  switch(keyCode) {
    default:
      generate();
      break;
  }
}

void generate() {
  fill(color(0, 0, 255, 255));
  rect(0, 0, 640, 480);
  
  groundLevel = 10 + (int) random(-2, 10);
  ground = new Block[64][48];
  
  for (int i = 0; i < 64; i++) {
    int deviation = (int) random(-1, 2);
    topSoil[i] = new Block(0, i, groundLevel + deviation);
    
    for (int j = groundLevel; j < 48; j++) {
      int blockHeight = j + deviation;
      if (blockHeight < 48) {
        ground[i][blockHeight] = new Block(1, i, blockHeight);
        ground[i][blockHeight].setDepth(blockHeight - groundLevel + deviation);
      }
    }
  }
}

class Block {
  
  private int type;
  private int x, y;
  private int depth;
  private color c;
  
  public Block(int type, int x, int y) {
    this.type = type;
    this.x = x;
    this.y = y;
  }
  
  void draw() {
    switch(type) {
      case 0:
        depth = 0;
        c = color(0, 255, 0, 255);
        break;
      case 1:
        c = color(175, 175, 0, 255);
        break;
      case 2:
        c = color(100, 100, 100, 255);
        break;
      case 3:
        c = color(0, 0, 0, 255);
        break;
      default:
        return;
    }
    
    fill(c);
    rect(x * 10, y * 10, 10, 10);
  }
  
  public void setDepth(int depth) {
    this.depth = depth;
    if (depth >= 15 + (int) random(-1, 4)) type = 3;
    else if (depth >= 4 + (int) random(-1, 3)) type = 2;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y; 
  }
}