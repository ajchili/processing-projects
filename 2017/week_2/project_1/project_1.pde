float offsetx1, offsety1, offsetx2, offsety2;
String text = "Your text here";
color color1, color2;

void setup() {
  size(500, 500);
  frameRate(60);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(25);
  
  getNewOffset();
  
  loop();
}

void draw() {
  background(0);
  
  fill(255);
  text(text, 250, 250);
  fill(color1);
  text(text, 250 + offsetx1, 250 + offsety1);
  fill(color2);
  text(text, 250 + offsetx2, 250 + offsety2);
}

void keyPressed() {
  getNewOffset();
  
  if (key == '') {
    if (text.length() > 0) {
      text = text.substring(0, text.length() - 1);
    } else {
      text = "Your text here";
    }
  } else {
    if (text.equals("Your text here")) {
      text = "" + key;
    } else if (text.length() < 14) {
      text += key;
    }
  }
}

void getNewOffset() {
  offsetx1 = random(-5, 5);
  offsety1 = random(-5, 5);
  offsetx2 = random(-5, 5);
  offsety2 = random(-5, 5);
  color1 = color(random(0, 255), random(0, 255), random(0, 255), random(25, 100));
  color2 = color(random(0, 255), random(0, 255), random(0, 255), random(25, 100));
}