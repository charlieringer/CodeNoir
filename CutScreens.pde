class CutScreens {
  //int currentLevel;
  StateClass state;
  PFont cyber;
  boolean paused;
  
  CutScreens(StateClass state, boolean paused) {
    //this.currentLevel = currentLevel;
    this.state = state;
    cyber = createFont("Fonts/renegado.ttf", 40); 
  }
  
  void drawCutScreens() {
    switch(currentLevel) {
      case 1:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 2:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 3:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 4:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 5:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 6:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 7:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 8:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 9:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
      case 10:
        background(255);
        fill(0);
        text("placeholder", width/2, height/2);
        
        //next level button (temporary placement)
        fill(0);
        rect(1000, 560, 200, 60);
        fill(255);
        textFont(cyber);
        text("Skip", 1050, 600);
        break;
    }
  }
  
  void handleMouse() {
    if(mouseX > 1000 && mouseX < 1200 && mouseY > 560 && mouseY < 620) {
      switch(currentLevel) {
        case 1:
          level = new Level("Levels/Level_1/level1.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 2:
          level = new Level("Levels/Level_2/level2.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 3:
          level = new Level("Levels/Level_3/level3.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 4:
          level = new Level("Levels/Level_4/level4.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 5:
          level = new Level("Levels/Level_5/level5.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 6:
          level = new Level("Levels/Level_6/level6.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 7:
          level = new Level("Levels/Level_7/level7.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 8:
          level = new Level("Levels/Level_8/level8.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 9:
          level = new Level("Levels/Level_9/level9.xml", state, paused); 
          state.state = State.INGAME;
          break;
        case 10:
          level = new Level("Levels/Level_10/level10.xml", state, paused); 
          state.state = State.INGAME;
          break;
      }
    }
  }
}