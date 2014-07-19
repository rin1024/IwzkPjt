import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

void setup() {
  String file_name = "/Users/yuki/aaaaaa.txt";

  try {
    File file = new File(file_name);
    FileWriter filewriter = new FileWriter(file, true);
    
    filewriter.write("はい。元気です¥r¥n");
    
    filewriter.close();
  }
  catch(IOException e) {
    println(e);
  }
}

void draw() {
}

