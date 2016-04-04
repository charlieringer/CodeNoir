class CutScreens {
  StateClass state;
  PImage background = loadImage("Art_Assets/In_Game/Cutscreens/newcutscreen.png");
  PImage cutscreen;
  PFont cyber;
  BufferedReader screenText;
  String line;
  ArrayList<String> text = new ArrayList<String>();
  int convoPos;
  boolean next;
  boolean custom = false;
  boolean img = false;

  CutScreens(StateClass state, String file) {
    this.state = state;
    cyber = createFont("Fonts/neuropol.ttf", 40);
    screenText = createReader(file);
    convoPos = 0;
    custom = false;
  }

  CutScreens(StateClass state, String image, String file) {
    this.state = state;
    cyber = createFont("Fonts/neuropol.ttf", 35);
    cutscreen = loadImage(image);
    screenText = createReader(file);
    convoPos = 0;
    img = true;
  }

  void drawCutScreens() {
    //read lines from text file to add conversation to text array
    try {
      line = screenText.readLine();
    } 
    catch(IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line != null) {
      text.add(line);
    }

    if (img == true) {
      background(0);
      image(cutscreen, 0, 0);
    } else {
      background(background);
    }
    //next level button
    rectMode(CORNER);
    fill(0);
    if (!custom) rect(0, 560, 700, 60);
    rect(1000, 560, 200, 60);
    fill(255);
    textFont(cyber);
    text("Skip", 1050, 600);
    if (!custom) text("Click/Space to continue", 50, 600);

    //prevent out of bounds exception, allows users to automatically go to next level after conversation is over
    if (convoPos > text.size()-1 && !custom) {
      next = true;
      switch(currentLevel) {
      case 1:
        level = new Level("Levels/Level_1/level1.xml", state); 
        state.state = State.INGAME;
        break;
      case 2:
        level = new Level("Levels/Level_2/level2.xml", state); 
        state.state = State.INGAME;
        break;
      case 3:
        level = new Level("Levels/Level_3/level3.xml", state); 
        state.state = State.INGAME;
        break;
      case 4:
        level = new Level("Levels/Level_4/level4.xml", state); 
        state.state = State.INGAME;
        break;
      case 5:
        level = new Level("Levels/Level_5/level5.xml", state); 
        state.state = State.INGAME;
        break;
      case 6:
        level = new Level("Levels/Level_6/level6.xml", state); 
        state.state = State.INGAME;
        break;
      case 7:
        level = new Level("Levels/Level_7/level7.xml", state); 
        state.state = State.INGAME;
        break;
      case 8:
        level = new Level("Levels/Level_8/level8.xml", state); 
        state.state = State.INGAME;
        break;
      case 9:
        level = new Level("Levels/Level_9/level9.xml", state); 
        state.state = State.INGAME;
        break;
      case 10: 
        level = new BossGame(state);
        state.state = State.INGAME;
        break;
      case 11:
        state.state = State.INGAME;
        break;
      }
      return;
    } else if (convoPos > text.size()-1 && custom) {
      state.state = State.INGAME;
      level.levelState = LevelState.LEVEL;
      return;
    }

    //display conversation text in correct position based on who is speaking
    if (custom == true) {
      fill(59, 59, 59);
      strokeWeight(6);
      stroke(0);
      rect(150, 400, 320, 90, 20);
      fill(255);
      textSize(20);
      text(text.get(convoPos).substring(3, text.get(convoPos).length()), 160, 415, 310, 85);
    } else {
      if (text.get(convoPos).substring(0, 2).equals("P:")) {
        fill(59, 59, 59);
        strokeWeight(6);
        stroke(0);
        rect(275, 50, 300, 90, 20);
        fill(255);
        textSize(20);
        text(text.get(convoPos).substring(3, text.get(convoPos).length()), 285, 65, 290, 85);
      } else if (text.get(convoPos).substring(0, 2).equals("H:")) {
        fill(59, 59, 59);
        strokeWeight(6);
        stroke(0);
        rect(635, 50, 320, 90, 20);
        fill(255);
        textSize(20);
        text(text.get(convoPos).substring(3, text.get(convoPos).length()), 645, 65, 310, 85);
      }
    }
  }

  void handleMouse() {
    //if skip is pressed, switch to level based on currentLevel
    if (mouseX > 1000 && mouseX < 1200 && mouseY > 560 && mouseY < 620) {
      switch(currentLevel) {
      case 1:
        level = new Level("Levels/Level_1/level1.xml", state); 
        state.state = State.INGAME;
        break;
      case 2:
        level = new Level("Levels/Level_2/level2.xml", state); 
        state.state = State.INGAME;
        break;
      case 3:
        level = new Level("Levels/Level_3/level3.xml", state); 
        state.state = State.INGAME;
        break;
      case 4:
        level = new Level("Levels/Level_4/level4.xml", state); 
        state.state = State.INGAME;
        break;
      case 5:
        level = new Level("Levels/Level_5/level5.xml", state); 
        state.state = State.INGAME;
        break;
      case 6:
        level = new Level("Levels/Level_6/level6.xml", state); 
        state.state = State.INGAME;
        break;
      case 7:
        level = new Level("Levels/Level_7/level7.xml", state); 
        state.state = State.INGAME;
        break;
      case 8:
        level = new Level("Levels/Level_8/level8.xml", state); 
        state.state = State.INGAME;
        break;
      case 9:
        level = new Level("Levels/Level_9/level9.xml", state); 
        state.state = State.INGAME;
        break;
      case 10:
        level = new BossGame(state); 
        state.state = State.INGAME;
        break;
      case 11:
        state.state = State.INGAME;
      }
    }
    //if screen is clicked anywhere above the skip button
    if (mouseX > 0 && mouseX < 1200 && mouseY > 0 && mouseY < 560) {
      convoPos++;
    }
  }

  void handleKeys() {
    if (key == ' ') {
      convoPos++;
    }
  }
}