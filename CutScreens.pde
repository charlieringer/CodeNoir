class CutScreens {
  StateClass state;
  PFont cyber;
  BufferedReader screenText;
  String line;
  ArrayList<String> text = new ArrayList<String>();
  int convoPos;
  boolean next;
  
  CutScreens(StateClass state, String file) {
    this.state = state;
    cyber = createFont("Fonts/renegado.ttf", 40);
    screenText = createReader(file);
    convoPos = 0;
  }
  
  void drawCutScreens() {
    //read lines from text file to add conversation to text array
    try {
      line = screenText.readLine();
    } catch(IOException e) {
      e.printStackTrace();
      line = null;
    }
    if(line != null) {
      text.add(line);
    }

    background(255);        
    //next level button (temporary placement)
    fill(0);
    rect(1000, 560, 200, 60);
    fill(255);
    textFont(cyber);
    text("Skip", 1050, 600);
    
    //conversation boxes (test)
    rect(100, 100, 300, 100);
    rect(600, 100, 300, 100);
    
    //prevent out of bounds exception
    if(convoPos > text.size()-1) {
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
          level = new Level("Levels/Level_10/level10.xml", state); 
          state.state = State.INGAME;
          break;
      }
      return;
     }
    
    //display conversation text in correct position based on who is speaking
    if(text.get(convoPos).substring(0, 2).equals("P:")) {
      fill(0);
      text(text.get(convoPos), 110, 150);
    } else if (text.get(convoPos).substring(0, 2).equals("H:")) {
      fill(0);
      text(text.get(convoPos), 610, 150);
    }
  }
  
  void handleMouse() {
    //if skip is pressed, switch to level based on currentLevel
    if(mouseX > 1000 && mouseX < 1200 && mouseY > 560 && mouseY < 620) {
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
          level = new Level("Levels/Level_10/level10.xml", state); 
          state.state = State.INGAME;
          break;
      }
    }
    //if screen is clicked anywhere above the skip button
    if(mouseX > 0 && mouseX < 1200 && mouseY > 0 && mouseY < 560) {
      convoPos++;
    }
  }
  
  void handleKeys() {
    if(key == ' ') {
      convoPos++;
    }
  }
}