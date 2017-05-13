class Circle {
  private int x, y, size;
  private color c = color((int)  random(0, 254), (int)  random(0, 254), (int) random(0, 254), (int) random(10, 100));
  
  public Circle(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public void draw() {
    fill(c);
    noStroke();
    ellipse(x, y, size, size);
  }
}

size(500, 500);

for (int i = 0; i < 100; i++) {
  Circle c = new Circle((int) random(100, 400), (int) random(100, 400), (int) random(10, 25));
  c.draw();
}