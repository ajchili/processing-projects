int x, y;
ArrayList<Light> lights = new ArrayList();

void setup() {
  size(600, 400);
  frameRate(60);
  noStroke();
  loop();
}

void draw() {
  fill(0);
  rect(0, 0, 600, 400);
  renderLight(x, y);
}

void mouseMoved() {
  x = mouseX;
  y = mouseY;
}

void mouseClicked() {
  lights.add(new Light(mouseX, mouseY));
}

void renderLight(int x, int y) {
  int size = 10;
  for (int i = -5; i <= 5; i++) {
    for (int j = -5; j <= 5; j++) {
      fill(255, 255, 0, 80 - ((Math.abs(i) * size) + (Math.abs(j) * size)));
      rect(x + i * size, y + j * size, size, size);
    }
  }
  
  for (Light light : lights) {
    for (int i = -5; i <= 5; i++) {
      for (int j = -5; j <= 5; j++) {
        fill(255, 255, 0, 80 - ((Math.abs(i) * size) + (Math.abs(j) * size)));
        rect(light.getX() + i * size, light.getY() + j * size, size, size);
      }
    }
  }
}

class Light {
  
  private int x;
  private int y;
  
  public Light(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
}