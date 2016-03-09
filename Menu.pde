class Menu {
 menuState MenuState;
 initialScreen screen;
 mainMenu mainScreen;
 continueGame Continue;
 Controls controls;
 Settings settings;
 StateClass state;
 boolean paused;
 
 
 Menu(StateClass state, boolean paused) {
   //MenuState = menuState.INITIAL;
   this.paused = paused;
   screen = new initialScreen();
   mainScreen = new mainMenu();
   Continue = new continueGame();
   controls = new Controls(paused);
   settings = new Settings();
   this.state = state;
 } 
  
 void drawMenu() { 
   switch(state.MenuState) {
     case INITIAL:
       screen.drawInitial();
       break;
     case MAIN:
       mainScreen.drawMain();
       break;
     case CONTINUEMENU:
       Continue.drawContinue();
       break;
     case CONTROLS:
       controls.drawControls();
       break;
     case SETTINGS:
       settings.drawSettings();
       break;
   }
 }
 
 void handleKey() {
   switch(state.MenuState) {
     case INITIAL:
       if(key == ' ') {
         state.MenuState = menuState.MAIN;
       }
       break;
   }
 }
 
 void handleMouse() {
    switch(state.MenuState) {
      case INITIAL:
        break;
      case MAIN:
        //new game is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 100 && mouseY < 150) {
          currentLevel = 1;
          state.state = State.CUTSCREENS;
        }
    
        //continue game is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 200 && mouseY < 250) {
          state.MenuState = menuState.CONTINUEMENU;
        }
    
        //controls is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 300 && mouseY < 350) {
          state.MenuState = menuState.CONTROLS;
        }
    
        //settings is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 400 && mouseY < 450) {
          state.MenuState = menuState.SETTINGS;
        }
    
        //quit is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 500 && mouseY < 550) {
          exit();
        }
        break;
      case CONTINUEMENU:
        //home button is pressed
        if(mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105) {
          state.MenuState = menuState.MAIN;
        }
        //level 1
        if(mouseX > 250 && mouseX < 350 && mouseY > 380 && mouseY < 480) {
          currentLevel = 1;
          state.state = State.CUTSCREENS;
        }
        //level 2
        if(mouseX > 400 && mouseX < 500 && mouseY > 380 && mouseY < 480) {
          currentLevel = 2;
          state.state = State.CUTSCREENS;
        }
        //level 3
        if(mouseX > 550 && mouseX < 650 && mouseY > 380 && mouseY < 480) {          
          currentLevel = 3;
          state.state = State.CUTSCREENS;
        }
        //level 4
        if(mouseX > 250 && mouseX < 350 && mouseY > 250 && mouseY < 350) {          
          currentLevel = 4;
          state.state = State.CUTSCREENS;
        }
        //level 5
        if(mouseX > 400 && mouseX < 500 && mouseY > 250 && mouseY < 350) {         
          currentLevel = 5;
          state.state = State.CUTSCREENS;
        }
        //level 6
        if(mouseX > 550 && mouseX < 650 && mouseY > 250 && mouseY < 350) {          
          currentLevel = 6;
          state.state = State.CUTSCREENS;
        }
        //level 7
        if(mouseX > 250 && mouseX < 350 && mouseY > 120 && mouseY < 220) {          
          currentLevel = 7;
          state.state = State.CUTSCREENS;
        }
        //level 8
        if(mouseX > 400 && mouseX < 500 && mouseY > 120 && mouseY < 220) {         
          currentLevel = 8;
          state.state = State.CUTSCREENS;
        }
        //level 9
        if(mouseX > 550 && mouseX < 650 && mouseY > 120 && mouseY < 220) {          
          currentLevel = 9;
          state.state = State.CUTSCREENS;
        }
        //level 10
        if(mouseX > 260 && mouseX < 640 && mouseY > 15 && mouseY < 95) {          
          currentLevel = 10;
          state.state = State.CUTSCREENS;
        }
        break;
      case CONTROLS:
        //home button is pressed when not paused
        if(mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105 && !paused) {
          state.MenuState = menuState.MAIN;
        }
        //if controls is accessed from the pause menu and return to game is pressed
        if(mouseX > 900 && mouseX < 1150 && mouseY > 25 && mouseY < 75 && paused) {
          level.levelState = level.prevState;
          state.state = State.INGAME;
        }
        break;
      case SETTINGS:
        //music note is pressed
        if(mouseX > 345 && mouseX < 505 && mouseY > 195 && mouseY < 355) {
          println("no music");
        }
        //speaker is pressed
        if(mouseX > 695 && mouseX < 870 && mouseY > 195 && mouseY < 355) {
          println("no SFX");
        }
        //home button is pressed
        if(mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105) {
          state.MenuState = menuState.MAIN;
        }
        break;
    }
 } 
}

class initialScreen {
  PFont cyber;
  PImage city;
  PImage protag;
  
  initialScreen() {
    cyber = createFont("Fonts/renegado.ttf", 130);
    city = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
    protag = loadImage("Art_Assets/Frontend/prot2.png");
    city.resize(1200, 620);
  }
  
  void drawInitial() {
   //background
   background(city);
   image( protag, 50, 100);
   
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

class mainMenu {
  PFont cyber;
  PImage scape;
  ArrayList<Button> buttons = new ArrayList<Button>();
  PImage protag;
  
  
  mainMenu() {
    cyber = createFont("Fonts/renegado.ttf", 30);
    scape = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
    protag = loadImage("Art_Assets/Frontend/prot2.png");
    scape.resize(1200, 620);
    
    //add buttons to arraylist
    buttons.add(new Button("New Game", 750, 100, 810, 135));
    buttons.add(new Button("Continue Game", 750, 200, 755, 235));
    buttons.add(new Button("Controls", 750, 300, 810, 335));
    buttons.add(new Button("Settings", 750, 400, 822, 435));
    buttons.add(new Button("Quit", 750, 500, 865, 535));
  }
  
  void drawMain() {
    //draws background
    background(scape);
    image( protag, 50, 100);
    
    //draws button banner
    fill(0);
    rect(750, 0, 300, 620);
    
    //draw game title
    fill(255);
    textSize(100);
    text("Code Noir", 30, 100);
    
    //draw all buttons
    for(int i = 0; i < buttons.size(); i++) {
      buttons.get(i).drawButton();
      buttons.get(i).checkHover();
    }
  }
}

class continueGame {
 PFont cyber;
 PImage scape, home;
 ArrayList<Button> buttons = new ArrayList<Button>();
  
 continueGame() {
   cyber = createFont("Fonts/renegado.ttf", 50);
   scape = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
   scape.resize(1200, 620);
   home = loadImage("Art_Assets/Frontend/home.png");
   home.resize(75, 75);
   //add buttons to arraylist
   buttons.add(new Button("1", 250, 380, 290, 440, 100, 100));
   buttons.add(new Button("2", 400, 380, 440, 440, 100, 100));
   buttons.add(new Button("3", 550, 380, 590, 440, 100, 100));
   buttons.add(new Button("4", 250, 250, 285, 310, 100, 100));
   buttons.add(new Button("5", 400, 250, 440, 310, 100, 100));
   buttons.add(new Button("6", 550, 250, 585, 310, 100, 100));
   buttons.add(new Button("7", 250, 120, 285, 180, 100, 100));
   buttons.add(new Button("8", 400, 120, 440, 180, 100, 100));
   buttons.add(new Button("9", 550, 120, 585, 180, 100, 100));
   buttons.add(new Button("10", 260, 15, 435, 65, 380, 80));
 }
 
 void drawContinue() {
   //draws background- temporary 
   background(scape);
   
   //draws home button
   fill(0);
   rect(1095, 20, 85, 85, 20);
   image(home, 1100, 25);
   
   //temporary placeholder for skyscraper
   rect(200, 0, 500, 620);
   
   //temporary windows
   for(int i = 0; i < buttons.size(); i++) {
     buttons.get(i).drawContinue();
     buttons.get(i).checkContinueHover();
   }
     
   //temporary door
   fill(255);
   rect(375, 510, 150, 220);
   fill(0);
   line(450, 510, 450, 730);  
 }
}

class Controls {
  PImage city, arrows, space, home;
  PFont cyber;
  boolean paused;
  
  Controls(boolean paused) {
    this.paused = paused;
    city = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
    city.resize(1200, 620);
    arrows = loadImage("Art_Assets/Frontend/arrows.png");
    arrows.resize(300, 200);
    space = loadImage("Art_Assets/Frontend/space_tab.png");
    space.resize(600, 200);
    home = loadImage("Art_Assets/Frontend/home.png");
    home.resize(75, 75);
    cyber = createFont("Fonts/renegado.ttf", 50);
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
    image(arrows, 125, 200);
    image(space, 475, 200);
    if(paused) {
      fill(0);
      rect(900, 25, 250, 50, 20);
      fill(255);
      textSize(20);
      text("Return To Game", 925, 55);
    } else {
      rect(1095, 20, 85, 85, 20);
      image(home, 1100, 25);
    }
  }
}

class Settings {
  PFont cyber;
  PImage city, music, sound, home;
  
  Settings() {
    cyber = createFont("Fonts/renegado.ttf", 50);
    city = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
    city.resize(1200, 620);
    music = loadImage("Art_Assets/Frontend/music.png");
    music.resize(150, 150);
    sound = loadImage("Art_Assets/Frontend/sound.png");
    sound.resize(165, 150);
    home = loadImage("Art_Assets/Frontend/home.png");
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

class Button {
  PFont cyber;
  PImage lock_yellow, lock_white;
  int rectX, rectY, textX, textY, wide, leng;
  String title;
  Boolean hover = false;
  Boolean completed = true;
  
  Button(String title, int rectX, int rectY, int textX, int textY) {
    this.rectX = rectX;
    this.rectY = rectY;
    this.textX = textX;
    this.textY = textY;
    this.title = title;
    
    cyber = createFont("Fonts/renegado.ttf", 30);
  }
  
  Button(String title, int rectX, int rectY, int textX, int textY, int fontSize) {
    this.rectX = rectX;
    this.rectY = rectY;
    this.textX = textX;
    this.textY = textY;
    this.title = title;
    
    cyber = createFont("Fonts/renegado.ttf", fontSize);
  }
  
  Button(String title, int rectX, int rectY, int textX, int textY, int wide, int leng) {
    this.rectX = rectX;
    this.rectY = rectY;
    this.textX = textX;
    this.textY = textY;
    this.title = title;
    this.wide = wide;
    this.leng = leng;
    
    cyber = createFont("Fonts/renegado.ttf", 30);
    lock_white = loadImage("Art_Assets/Frontend/lock_white.png");
    lock_white.resize(150, 150);
    lock_yellow = loadImage("Art_Assets/Frontend/lock_yellow.png");
    lock_yellow.resize(150, 150);
  }
  
  void drawButton() {
    if(hover == true) {
      //button outline
      fill(255);
      rect(rectX, rectY, 300, 50);
      
      //button text
      textFont(cyber);
      fill(0);
      text(title, textX, textY);
    } else {
      //button outline
      fill(0);
      rect(rectX, rectY, 300, 50);
    
      //button text
      textFont(cyber);
      fill(255);
      text(title, textX, textY);
    }
  }
  
  void drawContinue() {
   if(completed == true) {
     if(hover == false) {
       //button outline
       fill(255);
       rect(rectX, rectY, wide, leng);
       //button text
       textFont(cyber);
       fill(0);
       text(title, textX, textY);
     } else {
       //button outline
       fill(249, 255, 50);
       rect(rectX, rectY, wide, leng);
       //button text
       fill(0);
       text(title, textX, textY);
     }
   } else {
     if(hover == false) {
       //button outline
       fill(255);
       rect(rectX, rectY, wide, leng);
       //button locked
       image(lock_white, textX-35, textY-60);
     } else {
       //button outline
       fill(249, 255, 50);
       rect(rectX, rectY, wide, leng);
       //button locked
       image(lock_yellow, textX-35, textY-60);
     }
    }
   }
   
  void checkHover() {
    if(mouseX > rectX && mouseX < rectX + 300 && mouseY > rectY && mouseY < rectY + 50) {
      hover = true;
    } else {
      hover = false;
    }
  }
  
  void checkContinueHover() {
    if(mouseX > rectX && mouseX < rectX + wide && mouseY > rectY && mouseY < rectY + leng) {
      hover = true;
    } else {
      hover = false;
    }
  }
}