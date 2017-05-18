ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Triangle> triangles = new ArrayList<Triangle>();

void setup() {
  size(500, 500);
  frameRate(30);
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
  
public boolean isTriangleCreateable(Point p1, Point p2, Point p3) {
  return !(p1.equals(p2) || p1.equals(p3) || p2.equals(p3));
}

void reset() {
  triangles.clear();
  
  for (Point point : points) {
    point.setUsage(false);
  }
}

void mosaic() {
  reset();
  
  if (points.size() == 2) {
    fill(random(0, 255));
    noStroke();
    line(points.get(0).getX(), points.get(0).getY(), points.get(1).getX(), points.get(1).getY());
  } else if (points.size() > 2) {
    while (!allPointsUsed() && triangles.size() <= (points.size() - 2)) {
      for (Point p1 : points) {
        if (!p1.getUsage()) {
          for (Point p2 : points) {
            for (Point p3 : points) {
              if (triangles.size() > 0) {
                boolean isCreateable = true;
                for (Triangle triangle : triangles) {
                  if (triangle.equals(new Triangle(p1, p2, p3))) {
                    isCreateable = false;
                    break;
                  }
                }
                  
                if (isCreateable) {
                  if (isTriangleCreateable(p1, p2, p3)) {
                    triangles.add(new Triangle(p1, p2, p3));
                    p1.setUsage(true);
                    p2.setUsage(true);
                    p3.setUsage(true);
                  }
                }
              } else {
                if (isTriangleCreateable(p1, p2, p3)) {
                  triangles.add(new Triangle(p1, p2, p3));
                  p1.setUsage(true);
                  p2.setUsage(true);
                  p3.setUsage(true);
                }
              }
            }
          }
        }
      }
    }
  }
  
  while(triangles.size() > 1 && triangles.size() > (points.size() - 2)) {
    triangles.remove(0);
  }
  
  for (Triangle triangle : triangles) {
    triangle.draw();
    println(triangle.toString());
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
  
  public String toString() {
    return "(" + x + ", " + y + ")";
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
    boolean arg0 = p1.equals(triangle.getPoint(1)) && p2.equals(triangle.getPoint(2)) && p3.equals(triangle.getPoint(3));
    boolean arg1 = p1.equals(triangle.getPoint(1)) && p2.equals(triangle.getPoint(3)) && p3.equals(triangle.getPoint(2));
    boolean arg2 = p1.equals(triangle.getPoint(2)) && p2.equals(triangle.getPoint(1)) && p3.equals(triangle.getPoint(3));
    boolean arg3 = p1.equals(triangle.getPoint(2)) && p2.equals(triangle.getPoint(3)) && p3.equals(triangle.getPoint(1));
    boolean arg4 = p1.equals(triangle.getPoint(3)) && p2.equals(triangle.getPoint(1)) && p3.equals(triangle.getPoint(2));
    boolean arg5 = p1.equals(triangle.getPoint(3)) && p2.equals(triangle.getPoint(2)) && p3.equals(triangle.getPoint(1));
    return arg0 && arg1 && arg2 && arg3 && arg4 && arg5;
  }
  
  public String toString() {
    return "This triangle has points at [" + p1.toString() + ", " + p2.toString() + ", " + p3.toString() + "]";
  }
  
  void draw() {
    fill(random(0, 255), random(0, 255), random(0, 255));
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