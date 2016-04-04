class Menu {
  menuState MenuState;
  initialScreen screen;
  mainMenu mainScreen;
  continueGame Continue;
  Controls controls;
  Settings settings;
  StateClass state;

  Menu(StateClass state) {
    screen = new initialScreen();
    mainScreen = new mainMenu();
    Continue = new continueGame();
    controls = new Controls();
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
      if (key == ' ') {
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
      if (mouseX > 750 && mouseX < 1050 && mouseY > 100 && mouseY < 150) {
        currentLevel = 1;
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/level1cutscreen.png", "Levels/Level_1/Level 1 PreText.txt");
        state.state = State.CUTSCREENS;
      }

      //continue game is pressed
      if (mouseX > 750 && mouseX < 1050 && mouseY > 200 && mouseY < 250) {
        state.MenuState = menuState.CONTINUEMENU;
      }

      //controls is pressed
      if (mouseX > 750 && mouseX < 1050 && mouseY > 300 && mouseY < 350) {
        state.MenuState = menuState.CONTROLS;
      }

      //music on/off is pressed
      if (mouseX > 750 && mouseX < 1050 && mouseY > 400 && mouseY < 450) {
        //state.MenuState = menuState.SETTINGS;
        if (save.bgMusic == 1) {
          save.bgMusic = 0;
          save.outputSave();
        } else {
          save.bgMusic = 1;
          save.outputSave();
        }
      }

      //quit is pressed
      if (mouseX > 750 && mouseX < 1050 && mouseY > 500 && mouseY < 550) {
        exit();
      }
      break;
    case CONTINUEMENU:
      //home button is pressed
      if (mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105) {
        state.MenuState = menuState.MAIN;
      }
      //level 1
      //if(mouseX > 250 && mouseX < 350 && mouseY > 380 && mouseY < 480) {
      //  currentLevel = 1;
      //  cutScreens = new CutScreens(state, "Levels/Level_1/Level 1 PreText.txt");
      //  state.state = State.CUTSCREENS;
      //}
      //level 2
      if (mouseX > 610 && mouseX < 800 && mouseY > 427 && mouseY < 477 && save.level > 1) {
        currentLevel = 2;
        cutScreens = new CutScreens(state, "Levels/Level_2/Level 2 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 3
      if (mouseX > 400 && mouseX < 590 && mouseY > 427 && mouseY < 477 && save.level > 2) {  
        currentLevel = 3;
        cutScreens = new CutScreens(state, "Levels/Level_3/Level 3 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 4
      if (mouseX > 610 && mouseX < 800 && mouseY > 327 && mouseY < 377 && save.level > 3) {          
        currentLevel = 4;
        cutScreens = new CutScreens(state, "Levels/Level_4/Level 4 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 5
      if (mouseX > 400 && mouseX < 590 && mouseY > 327 && mouseY < 377 && save.level > 4) {         
        currentLevel = 5;
        cutScreens = new CutScreens(state, "Levels/Level_5/Level 5 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 6
      if (mouseX > 610 && mouseX < 800 && mouseY > 227 && mouseY < 277 && save.level > 5) {          
        currentLevel = 6;
        cutScreens = new CutScreens(state, "Levels/Level_6/Level 6 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 7
      if (mouseX > 400 && mouseX < 590 && mouseY > 227 && mouseY < 277 && save.level > 6) {          
        currentLevel = 7;
        cutScreens = new CutScreens(state, "Levels/Level_7/Level 7 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 8
      if (mouseX > 610 && mouseX < 800 && mouseY > 127 && mouseY < 177 && save.level > 7) {         
        currentLevel = 8;
        cutScreens = new CutScreens(state, "Levels/Level_8/Level 8 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 9
      if (mouseX > 400 && mouseX < 590 && mouseY > 127 && mouseY < 177 && save.level > 8) {          
        currentLevel = 9;
        cutScreens = new CutScreens(state, "Levels/Level_9/Level 9 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      //level 10
      if (mouseX > 550 && mouseX < 700 && mouseY > 27 && mouseY < 77 && save.level > 9) {          
        currentLevel = 10;
        //potentially not needed?
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/finalcs.png", "Levels/Level_10/Level 10 PreText.txt");
        state.state = State.CUTSCREENS;
        state.MenuState = menuState.MAIN;
      }
      break;
    case CONTROLS:
      //home button is pressed when not paused
      if (mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105 && !paused) {
        state.MenuState = menuState.MAIN;
      }
      //if controls is accessed from the pause menu and return to game is pressed
      if (mouseX > 900 && mouseX < 1150 && mouseY > 25 && mouseY < 75 && paused) {
        level.levelState = level.prevState;
        state.state = State.INGAME;
      }
      break;
    case SETTINGS:
      //music note is pressed
      if (mouseX > 345 && mouseX < 505 && mouseY > 195 && mouseY < 355) {
      }
      //speaker is pressed
      if (mouseX > 695 && mouseX < 870 && mouseY > 195 && mouseY < 355) {
      }
      //home button is pressed when not paused
      if (mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105 && !paused) {
        state.MenuState = menuState.MAIN;
      }
      //if controls is accessed from the pause menu and return to game is pressed
      if (mouseX > 900 && mouseX < 1150 && mouseY > 25 && mouseY < 75 && paused) {
        level.levelState = level.prevState;
        state.state = State.INGAME;
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
    city = loadImage("Art_Assets/Frontend/febg.jpeg");
    protag = loadImage("Art_Assets/Frontend/Menu/prot2eye.png");
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
  boolean music = true;


  mainMenu() {
    cyber = createFont("Fonts/renegado.ttf", 30);
    scape = loadImage("Art_Assets/Frontend/febg.jpeg");
    protag = loadImage("Art_Assets/Frontend/Menu/prot2eye.png");
    scape.resize(1200, 620);

    //add buttons to arraylist
    buttons.add(new Button("New Game", 750, 100, 810, 135));
    buttons.add(new Button("Continue Game", 750, 200, 755, 235));
    buttons.add(new Button("Controls", 750, 300, 810, 335));
    buttons.add(new Button("Music On/Off", 750, 400, 770, 435));
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
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).drawButton();
      buttons.get(i).checkHover();
    }
    textSize(20);
    text("Please play with brightness turned up.", 10, 600);
  }
}

class continueGame {
  PFont cyber;
  PImage scape, home, skyscraper, lockImg;
  ArrayList<Button> buttons = new ArrayList<Button>();

  continueGame() {
    cyber = createFont("Fonts/renegado.ttf", 50);
    scape = loadImage("Art_Assets/Frontend/febg.jpeg");
    scape.resize(1200, 620);
    home = loadImage("Art_Assets/Frontend/home.png");
    home.resize(75, 75);
    lockImg = loadImage("Art_Assets/Frontend/Menu/lock_white.png");
    skyscraper = loadImage("Art_Assets/Frontend/Menu/continuegame.png");
    //add buttons to arraylist
    buttons.add(new Button("Reception", 350, 527, 360, 560, 190, 55, 25));
    buttons.add(new Button("Accounting", 610, 427, 615, 460, 190, 50, 25));
    buttons.add(new Button("Sales", 400, 427, 450, 460, 190, 50, 25));
    buttons.add(new Button("Roboguard HQ", 610, 327, 615, 358, 190, 50, 19));
    buttons.add(new Button("Server Farm", 400, 327, 415, 358, 190, 50, 19));
    buttons.add(new Button("Archives", 610, 227, 640, 260, 190, 50, 25));
    buttons.add(new Button("R+D", 400, 227, 470, 260, 190, 50, 25));
    buttons.add(new Button("HR", 610, 127, 685, 160, 190, 50, 22));
    buttons.add(new Button("Board Room", 400, 127, 405, 160, 190, 50, 22));
    buttons.add(new Button("CEO", 550, 27, 570, 60, 150, 50, 25));
  }

  void drawContinue() {
    //draws background
    background(scape);

    //draws home button
    fill(0);
    rect(1095, 20, 85, 85, 20);
    image(home, 1100, 25);

    //draws skyscraper image
    image(skyscraper, 300, 0);

    //draws buttons
    for (int i = 0; i < buttons.size(); i++) {
      buttons.get(i).drawContinue();
      buttons.get(i).checkContinueHover();
    }

    //checks save.level and locks non-completed levels
    buttons.get(0).completed = true;
    switch(save.level) {
      case 2: 
        buttons.get(1).completed = true;
        break;
      case 3:
        buttons.get(2).completed = true;
        break;
      case 4:
        buttons.get(3).completed = true;
        break;
      case 5:
        buttons.get(4).completed = true;
        break;
      case 6:
        buttons.get(5).completed = true;
        break;
      case 7:
        buttons.get(6).completed = true;
        break;
      case 8:
        buttons.get(7).completed = true;
        break;
      case 9:
        buttons.get(8).completed = true;
        break;
      case 10:
        buttons.get(9).completed = true;
        break;
    }
  }
}

class Controls {
  PImage city, arrows, space, home, pause;
  PFont cyber;

  Controls() {
    city = loadImage("Art_Assets/Frontend/febg.jpeg");
    city.resize(1200, 620);
    arrows = loadImage("Art_Assets/Frontend/Controls/arrows.png");
    arrows.resize(300, 200);
    space = loadImage("Art_Assets/Frontend/Controls/space_tab.png");
    space.resize(600, 200);
    pause = loadImage("Art_Assets/Frontend/Controls/pause.png");
    pause.resize(600, 40);
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
    rect(295, 495, 600, 50, 20); 
    image(arrows, 125, 200);
    image(space, 475, 200);
    image(pause, 300, 500);

    //home button drawn if this menu is accessed from front end, 'return to game' displayed if accessed from in-game
    if (paused) {
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
    city = loadImage("Art_Assets/Frontend/febg.jpeg");
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
    rect(320, 390, 200, 50, 20);
    rect(625, 390, 320, 50, 20);
    image(music, 350, 200);
    image(sound, 700, 200);

    if (paused) {
      fill(0);
      rect(900, 25, 250, 50, 20);
      fill(255);
      textSize(20);
      text("Return To Game", 925, 55);
    } else {
      fill(0);
      rect(1095, 20, 85, 85, 20);
      image(home, 1100, 25);
    }

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
  PImage lock;
  int rectX, rectY, textX, textY, wide, leng, fontSize;
  String title;
  Boolean hover = false;
  Boolean completed;

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

  Button(String title, int rectX, int rectY, int textX, int textY, int wide, int leng, int fontSize) {
    this.rectX = rectX;
    this.rectY = rectY;
    this.textX = textX;
    this.textY = textY;
    this.title = title;
    this.wide = wide;
    this.leng = leng;
    this.fontSize = fontSize;
    completed = false;

    cyber = createFont("Fonts/renegado.ttf", fontSize);
    lock = loadImage("Art_Assets/Frontend/Menu/lock.png");  
  }

  void drawButton() {
    if (hover == true) {
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
    if (completed == true) {
      if (hover == false) {
        //button outline
        noStroke();
        fill(48, 48, 48);
        rect(rectX, rectY, wide, leng);
        //button text
        textFont(cyber);
        textSize(fontSize);
        fill(255);
        text(title, textX, textY);
        stroke(0);
      } else {
        //button text
        textSize(fontSize);
        fill(0);
        text(title, textX, textY);
      }
    } else if(title.equals("CEO") && !completed) {
        //button outline
        stroke(48, 48, 48);
        fill(48, 48, 48);
        rect(rectX, rectY, wide, leng);
        //button locked
        image(lock, rectX+38, rectY);
    } else {
        //button outline
        stroke(48, 48, 48);
        fill(48, 48, 48);
        rect(rectX, rectY, wide, leng);
        //button locked
        image(lock, rectX+75, rectY);
      }
  }

  void checkHover() {
    if (mouseX > rectX && mouseX < rectX + 300 && mouseY > rectY && mouseY < rectY + 50) {
      hover = true;
    } else {
      hover = false;
    }
  }

  void checkContinueHover() {
    if (mouseX > rectX && mouseX < rectX + wide && mouseY > rectY && mouseY < rectY + leng) {
      hover = true;
    } else {
      hover = false;
    }
  }
}