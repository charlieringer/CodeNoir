class initialScreen {
  PFont cyber;
  PImage city;
  
  initialScreen() {
    cyber = createFont("renegado.ttf", 130);
    city = loadImage("pixels-3.jpeg");
    city.resize(1200, 620);
  }
  
  void drawInitial() {
   //background
   background(city);
   
   //game title and banner
   //fill(0);
   //rect(170, 205, 870, 110, 20);
   textFont(cyber);
   fill(255);
   text("Code Noir", 175, 300);
   
   //press space to continue
   fill(0);
   rect(0, 450, 1200, 75);
   fill(255);
   textSize(40);
   text("Press space to continue", 275, 500);
  }
}