import processing.sound.*;

int rectX, rectY;
int rectSize = 90;
boolean rectOver = false;
color rectColor, rectHighlight;

AudioIn in;

Amplitude amp;

float threshold = 0.46; //not sure of the units, but this is the recommended units for my mic
//Volume goes from 0 to 0.5 (strangely enough)

float largest = 0;

SoundFile file;

void setup() {
 size(600, 600);
 background(255);
 
 //Button to allow for exit
 rectColor = color(0);
 rectHighlight = color(100);
 rectX = width/2-rectSize-10;
 rectY = height/2-rectSize/2;
 
 //Setup microphone input
 amp = new Amplitude(this);
 in = new AudioIn(this, 0);
 in.start();
 amp.input(in);
 
 
 //Setup mp3 file to play when too loud
 try {
   file = new SoundFile(this, "File0030.wav");
 }
 catch(Exception e) {
   e.printStackTrace();
   System.exit(1);
 }
 
}

void draw() {
  update(mouseX, mouseY);
  
  //change color if mouse is over the button
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  
  rect(rectX, rectY, rectSize*2, rectSize);
  
  fill(255);
  text("Exit button", rectX+50, rectY+50);
  
  
  fill(0);
  text("shut up program running", width/2-rectSize/2, 10);
  
  
  //Allows to deal with numbers not in decimal range
  float volume = amp.analyze();
  
  //Loud checker
  if (threshold < volume) {
    file.play();
    delay(2000);
    String volumeString = "Your volume was at " + volume + " units";
    background(255);
    text(volumeString, width/3, height/4);
    volume = 0;
  }
  /*
  need a threshold to keep me quieter
  */
}

void update (int x, int y) {
  if (overRect(rectX, rectY, rectSize, rectSize)) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
 if (rectOver) {
   println("Exit program");
   System.exit(0);
 }
}

boolean overRect (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
   return false; 
  }
}
