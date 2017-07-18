private color c = color(90, 100, 255, 100);
private Water water = new Water();

void setup() {
  size(640, 480);
  frameRate(30);
  noStroke();
  loop();
}

void draw() {
  background(255);
  fill(0);
  
  text("Particle count: " + water.getParticleCount(), 16, 16);
  water.draw();
}

void keyPressed() {
  switch (keyCode) {
    case 38:
      water.setParticleCount(water.getParticleCount() + 1);
      break;
    case 40:
      water.setParticleCount(water.getParticleCount() > 0 ? water.getParticleCount() - 1 : 1);
      break;
    case 82:
      water = new Water(water.getParticleCount());
      break;
    default:
      break;
  }
}

class WaterParticle {
  
  private int x, y;
  
  public WaterParticle(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void draw() {
    fill(c);
    ellipse(x, y, 20, 20);
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y; 
  }
  
  void setX(int x) {
    this.x = x; 
  }
  
  void setY(int y) {
    this.y = y;
  }
}

class Water {
  
  private int particleCount = 100;
  private ArrayList<WaterParticle> particles = new ArrayList();
  
  public Water() {
    createParticles();
  }
  
  public Water(int particleCount) {
    this.particleCount = particleCount;
    createParticles();
  }
  
  void draw() {
    move(); 
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).draw(); 
    }
  }
  
  void move() {
    for (int i = 0; i < particles.size(); i++) {
      for (int j = 0; j < particles.size(); j++) {
        if (Math.abs(particles.get(i).getX() - particles.get(j).getX()) <= 10) {
          int movement = (int) random(-2, 2);
          particles.get(i).setX(particles.get(i).getX() + movement);
          particles.get(j).setX(particles.get(j).getX() - movement);
        }
        
        if (particles.get(i).getX() < 20) particles.get(i).setX(20);
        else if (particles.get(i).getX() > 620) particles.get(i).setX(620);
        
        if (particles.get(j).getX() < 20) particles.get(j).setX(20);
        else if (particles.get(j).getX() > 620) particles.get(j).setX(620);
        
        if (particles.get(i).getY() < 460) particles.get(i).setY(particles.get(i).getY() + (int) random(-0.9, 1.1));
        else particles.get(i).setY(460);
          
        
        if (Math.abs(particles.get(i).getY() - particles.get(j).getY()) <= 10 && particles.get(i).getY() >= 20) particles.get(i).setY(particles.get(i).getY() - (int) random(-0.9, 2));
      }
    }
  }
  
  void createParticles() {
    particles.clear();
    for (int i = 0; i < particleCount; i++) {
      particles.add(new WaterParticle(320 + (int) random(-300, 300), 240 - (int) random(0, 200)));
    }
  }
  
  void setParticleCount(int particleCount) {
    this.particleCount = particleCount;
  }
  
  int getParticleCount() {
    return particleCount;
  }
}