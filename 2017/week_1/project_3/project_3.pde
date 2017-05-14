String text = "";
int rows = 1;

void setup() {
  size(500, 500);
  frameRate(60);
  loop();
}

void draw() {
  background(255);

  fill(0);
  noStroke();
  textSize(30);
  textAlign(CENTER, CENTER);
  if (text.length() == 0) {
    text("Hello World!", 250, 250);
  } else {
    text("Hello " + text + "!", 250, 250);
  }
}

void keyTyped() {
  if (key == '') {
    if ((text.length() - 13) % 15 == 0 || text.length() == 13) {
      text = text.substring(0, text.length() - 2);
    } else if (text.length() > 0) {
      text = text.substring(0, text.length() - 1);
    }
  } else {
    if (rows != 8) {
      if ((text.length() - 13) % 15 == 0 || text.length() == 13) {
        if (rows != 7) {
          text += "\n";
        }
        rows++;
      } else {
        text += key; 
      }
    }
  }
}