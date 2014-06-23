void setup() {
  // set window size
  // size(window_width, window_height);
  size(640, 480);
}

void draw() {
  drawCircle();
  drawLine();
}

/**
 * how to draw circle
 */
void drawCircle() {
  // disable draw circle line
  noStroke();
  // set line color
  // stroke(red, green, blue);
  //stroke(0, 255, 0);
  // set line width
  //strokeWeight(10);
  // set inner circle color
  // fill(red, green, blue);
  fill(255, 0, 0);
  // draw circle
  // ellipse(x, y, width, height)
  ellipse(100, 100, 50, 50);
}

/**
 * how to draw line
 */
void drawLine() {
  stroke(0);
  line(0, 0, 100, 50);
}

