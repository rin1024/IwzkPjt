import ddf.minim.analysis.*;
import ddf.minim.*;
import oscP5.*;
import netP5.*;

Minim minim;
OscP5 oscP5;
NetAddress myRemoteLocation;

AudioInput in; //オーディオ入力
FFT fft; //FFTクラス

int maxFreqIndex = 0;
float maxFreqVol = 0;

void setup() {
  size(1024, 400);

  oscP5 = new OscP5(this, 1234);//自分のポート番号
  myRemoteLocation = new NetAddress("127.0.0.1", 5555);//IPaddress,相手のポート番号

  //Minim初期化
  minim = new Minim(this);
  //ステレオでオーディオ入力
  in = minim.getLineIn(Minim.STEREO, 512);
  //FFTを新規に行う
  fft = new FFT(in.bufferSize(), in.sampleRate());
  //分析窓は、ハミング窓で
  fft.window(FFT.HAMMING);
  
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(0);
  
  //FFT変換実行
  fft.forward(in.mix);

  //グラフ生成
  maxFreqIndex = 0;
  maxFreqVol = 0.0;
  for (int i = 0; i < fft.specSize(); i++) {
    if (maxFreqVol < fft.getBand(i)) {
      maxFreqIndex = i;
      maxFreqVol = fft.getBand(i);
    }

    float h = map(i, 0, fft.specSize(), 0, 180);
    stroke(h, 100, 100);
    strokeWeight(2);
    float x = map(i, 0, fft.specSize(), 0, width);
    line(x, height, x, height - fft.getBand(i) * 8);
  }
  
  String _str = "maxFreqIndex: " + maxFreqIndex + ", maxFreqVol: " + maxFreqVol;
  println(_str);
  text(_str, 100, 100, 300, 300);

  OscMessage myMessage = new OscMessage("/freq");
  myMessage.add(maxFreqIndex);
  myMessage.add(maxFreqVol);
  oscP5.send(myMessage, myRemoteLocation); 
}

void mousePressed(){
/*
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(mouseX);//add message
  myMessage.add(mouseY);
  oscP5.send(myMessage, myRemoteLocation); 
*/
}

void stop() {
  minim.stop();
  super.stop();
}

