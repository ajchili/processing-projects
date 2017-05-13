int min = 100;
int max = 400;
ArrayList<Circle> circles = new ArrayList();
ArrayList<Line> lines = new ArrayList();

void setup() {
  size(500, 500);
  
  for (int i = 0; i < 50; i++) {
    circles.add(new Circle(random(min, max), random(min, max), (int) random(10, 50)));
  }
}

void draw() {
  background(255);
  lines.clear();
  
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).move();
    circles.get(i).draw();
    
    for (int j = 0; j < circles.size(); j++) {
      if (circles.get(j) != circles.get(i)) {
        if (circles.get(i).getDistance(circles.get(j).getX(), circles.get(j).getY()) <= 50) {
          lines.add(new Line(circles.get(i).getX(), circles.get(i).getY(), circles.get(j).getX(), circles.get(j).getY()));
        }
      }
    }
  }
  
  for (Line line : lines) {
    line.draw();
  }
  
  
  fill(0, 0, 0, 10);
  noStroke();
  rect(10, 15, 130, 35);
  fill(0);
  text("Circle count: " + circles.size(), 15, 30);
  text("Connection count: " + lines.size(), 15, 45);
}

void keyPressed() {
  if (keyCode == 40) {
    if (circles.size() > 1) {
      circles.remove(0);
    }
  } else if (keyCode == 38) {
    if (circles.size() < 1000) {
      circles.add(new Circle(random(min, max), random(min, max), (int) random(10, 50)));
    }
  }
}

void mouseMoved() {
  boolean canEnable = true;
  for (Circle circle : circles) {
    if (mouseX <= (circle.getX() + circle.getSize()) && mouseX >= (circle.getX() - circle.getSize()) && mouseY <= (circle.getY() + circle.getSize()) && mouseY >= (circle.getY() - circle.getSize()) && canEnable) {
      circle.setHovering(true);
      canEnable = false;
    } else {
      circle.setHovering(false);
    }
  }
}

class Circle {
  private float x, y, xStep, yStep;
  private int size, dir;
  private boolean isHovering = false;
  private color c = color((int)  random(0, 254), (int)  random(0, 254), (int) random(0, 254), (int) random(10, 100));
  
  public Circle(float x, float y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    dir = (int) random(0, 360);
    xStep = (random(0, 1) > .5) ? sin(dir) : cos(dir);
    yStep = (random(0, 1) > .5) ? sin(dir) : cos(dir);
    if ((abs(xStep) + abs(yStep)) < .00001) {
      circles.remove(this);
      circles.add(new Circle(random(min, max), random(min, max), (int) random(10, 50)));
    }
  }
  
  public void draw() {
    fill(c);
    noStroke();
    ellipse(x, y, size, size);
    rect(x - size / 8, y - size / 8, size / 4, size / 4);
    
    if (isHovering) {
      fill(0);
      stroke(0);
      text("X: " + (int) x + "\nY: " + (int) y + "\nSpeed: " + (abs(xStep) + abs(yStep)), x, y);
    }
  }
  
  public void move() {
    if (x < -size || x > (500 + size) || y < -size || y > (500 + size)) {
      circles.remove(this);
      circles.add(new Circle(random(min, max), random(min, max), (int) random(10, 50)));
    } else {
      x += xStep;
      y += yStep;
    }
  }
  
  public void setHovering(boolean isHovering) {
    this.isHovering = isHovering; 
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y; 
  }
  
  public int getSize() {
    return size; 
  }
  
  public float getDistance(float x, float y) {
    return dist(this.x, this.y, x, y);
  }
  
  public boolean isHovering() {
    return isHovering; 
  }
}

class Line {
  private float x1, y1, x2, y2;
  
  public Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    if (checkIfLineExists()) {
      lines.remove(this); 
    }
  }
  
  public void draw() {
    stroke(126);
    line(x1, y1, x2, y2);
  }
  
  public float[] getCoords() {
    float[] coords = new float[4];
    coords[0] = x1;
    coords[1] = y1;
    coords[2] = x2;
    coords[3] = y2;
    return coords;
  }
  
  private boolean checkIfLineExists() {
    for (Line line : lines) {
      if (line.getCoords()[0] == x1 && line.getCoords()[1] == y1 && line.getCoords()[2] == x2 && line.getCoords()[3] == y2) {
        return true;
      }
    }
    return false;
  }
}