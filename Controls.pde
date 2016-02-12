class Controls {
  PImage city, arrows, space, home;
  PFont cyber;
  
  Controls() {
    city = loadImage("pixels-3.jpeg");
    city.resize(1200, 620);
    arrows = loadImage("arrows.png");
    arrows.resize(300, 200);
    space = loadImage("space_tab.png");
    space.resize(600, 200);
    home = loadImage("home.png");
    home.resize(75, 75);
    cyber = createFont("renegado.ttf", 50);
  }
  
  void drawControls() {
    //draws background
    background(city); 
    
    //draw various text
    fill(255);
    textFont(cyber);
    text("Controls", 30, 50);
    
    //draws control images
    fill(0);
    rect(120, 195, 310, 210, 20);
    rect(470, 195, 610, 210, 20);
    rect(1095, 20, 85, 85, 20);
    image(arrows, 125, 200);
    image(space, 475, 200);
    image(home, 1100, 25);
  }
}