class Settings {
  PFont cyber;
  PImage city, music, sound, home;
  
  Settings() {
    cyber = createFont("renegado.ttf", 50);
    city = loadImage("pixels-3.jpeg");
    city.resize(1200, 620);
    music = loadImage("music.png");
    music.resize(150, 150);
    sound = loadImage("sound.png");
    sound.resize(165, 150);
    home = loadImage("home.png");
    home.resize(75, 75);
  }
  
  void drawSettings() {
   //draw background
   background(city);
    
   //draw images
   fill(0);
   rect(345, 195, 160, 160, 20);
   rect(695, 195, 175, 160, 20);
   rect(1095, 20, 85, 85, 20);
   rect(320, 390, 200, 50, 20);
   rect(625, 390, 320, 50, 20);
   image(music, 350, 200);
   image(sound, 700, 200);
   image(home, 1100, 25);
    
   //draw various text
   fill(255);
   textFont(cyber);
   text("Settings", 30, 50); 
   text("Music", 335, 430);
   text("Sound FX", 635, 430);
  }
  
  
  
  
  
  
}