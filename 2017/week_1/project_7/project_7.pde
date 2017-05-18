ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(500, 500);
  frameRate(60);
  loop();
}

void draw() {
  background(255);
  
  mosaic();
  
  for (Point point : points) {
    point.draw(); 
  }
}

boolean allPointsUsed() {
  for (Point point : points) {
    if (!point.getUsage()) {
      return false;
    }
  }
  
  return true;
}

void reset() {
  for (Point point : points) {
    point.setUsage(false);
  }
}

void mosaic() {
  reset();
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  
  if (points.size() == 2) {
    fill(random(0, 255));
    noStroke();
    line(points.get(0).getX(), points.get(0).getY(), points.get(1).getX(), points.get(1).getY());
  } else if (points.size() > 2) {
    while (!allPointsUsed()) {
      for (Point point : points) {
        
      }
    }
  }
  
  for (Triangle triangle : triangles) {
    triangle.draw();
  }
}

void mousePressed() {
  boolean addPoint = true;
  int x = mouseX;
  int y = mouseY;
  
  for (Point point : points) {
    if (point.getX() == x || point.getY() == y) {
      addPoint = false;
    }
  }
  
  if (addPoint) {
    points.add(new Point(x, y)); 
  }
}

class Point {
  
  private int x, y;
  private boolean isInTriangle;
  
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
    isInTriangle = false;
  }
  
  public boolean equals(Point point) {
    return x == point.getX() && y == point.getY();
  }
  
  public boolean getUsage() {
    return isInTriangle; 
  }
  
  void draw() {
    fill(0);
    noStroke();
    ellipse(x, y, 5, 5);
  }
  
  void setUsage(boolean isInTriangle) {
    this.isInTriangle = isInTriangle; 
  }
  
  public int getX() {
    return x; 
  }
  
  public int getY() {
    return y; 
  }
}

class Triangle { 
  
  private Point p1, p2, p3;
 
  public Triangle(Point p1, Point p2, Point p3) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
  
  public boolean equals(Triangle triangle) {
    return p1.equals(triangle.getPoint(1)) && p2.equals(triangle.getPoint(2)) && p3.equals(triangle.getPoint(3));
  }
  
  void draw() {
    fill(random(0, 255));
    noStroke();
    triangle(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  }
  
  public Point getPoint(int point) {
    switch(point) {
      case 1:
        return p1;
      case 2:
        return p2;
      case 3:
        return p3;
      default:
        return p1;
    }
  }
}