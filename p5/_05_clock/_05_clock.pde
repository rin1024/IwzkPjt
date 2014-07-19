void setup() {
  //frameRate(1);
}

void draw() {
  String txt = "現在時刻は " + hour() + ":" + minute() + ":" + second(); 

  text(txt, 10, 20);
  println(txt);
}

