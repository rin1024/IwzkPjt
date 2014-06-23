import oscP5.*;
import netP5.*;

int NUM_OF_CIRCLE = 40;
 
OscP5 oscP5;
CircleElement[] elementArray;

void setup() {
  size(1000, 600);
  smooth();

  oscP5 = new OscP5(this, 5555); // 自分のポート番号
  oscP5.plug(this, "getData", "/freq"); // getDta:受け取る関数

  elementArray = new CircleElement[NUM_OF_CIRCLE];
  for (int i=0; i<elementArray.length;i++) {
    float xspeed = 0.0;//random(0.1, 0.2);
    float yspeed = random(0.1, 5.0);
    float rad = random(20, 70);
    float xpos = i * (20 + (width / elementArray.length)) + random(0, 50);
    float ypos = height / 2;
    float xdirection = random(-1, 1);
    float ydirection = random(-1, 1);

    CircleElement element = new CircleElement(xspeed, yspeed, rad, xpos, ypos, xdirection, ydirection);
    elementArray[i] = element;
  }
}

void draw() {
  background(255);

  float lastX = -1.0;
  float lastY = -1.0;
  for (CircleElement element:elementArray) {
    element.draw();
    
    if (lastX != -1.0) {
      stroke(200);
      line(lastX, lastY, element.xpos, element.ypos);
    }
    
    lastX = element.xpos;
    lastY = element.ypos;
  }
}

void getData(int freqIndex, float freqVol) {
  if (elementArray[freqIndex] != null && freqVol > 0.0) {
    elementArray[freqIndex].setRad(freqVol * 8);
  }
  
  println("freqIndex: " + freqIndex + ", freqVol: " + freqVol);
}
 

/**
 * circle element
 */
class CircleElement {
  float xspeed;
  float yspeed;
  float rad;
  float xpos;
  float ypos;
  float xdirection;         // direction of X coord
  float ydirection;         // direction of Y coord

  CircleElement(float xspeed, float yspeed, float rad, float xpos, float ypos, float xdirection, float ydirection) {
    this.xspeed = xspeed; 
    this.yspeed = yspeed; 
    this.rad = rad;
    this.xpos = xpos;
    this.ypos = ypos;
    this.xdirection = xdirection;
    this.ydirection = ydirection;
  }

  void draw() {
    xpos = xpos + ( xspeed * xdirection );
    ypos = ypos + ( yspeed * ydirection );

    if (xpos > width - rad || xpos < rad) {
      xdirection *= -1;
    }
    
    if (ypos > height - rad || ypos < rad) {
      ydirection *= -1;
    }

    noStroke();
    fill(0, 255 / 100 * rad, 120, 120);
    ellipseMode(CENTER);
    //ellipse(xpos, ypos, rad / 2 + random(0, rad / 2), rad / 2 + random(0, rad / 2));
    //float v =  + random(0, rad / 2);
    //ellipse(xpos, ypos, rad / 2 + v, rad / 2 + v);
    ellipse(xpos, ypos, rad, rad);
  }
  
  void setRad(float _rad) {
    this.rad = _rad;
  }
}

