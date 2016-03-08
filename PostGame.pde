class PostGame {
 PImage scape;
 PFont cyber;
 ArrayList<Button> lose = new ArrayList<Button>();
 ArrayList<Button> win = new ArrayList<Button>();
 StateClass state;
 int currentLevel;
 boolean paused;
  
 PostGame(StateClass state, int currentLevel, boolean paused) {
   this.state = state;
   this.currentLevel = currentLevel;
   this.paused = paused;
   scape = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
   scape.resize(1200, 620);
   cyber = createFont("Fonts/renegado.ttf", 80);
   //buttons for game over screen
   lose.add(new Button("Play Again", 50, 525, 100, 560, 30));
   lose.add(new Button("Return To Menu", 450, 525, 470, 560, 26));
   lose.add(new Button("Quit", 850, 525, 960, 560, 30));
   //buttons for game win screen
   win.add(new Button("Next Level", 50, 525, 100, 560, 30));
   win.add(new Button("Return To Menu", 450, 525, 470, 560, 26));
   win.add(new Button("Quit", 850, 525, 960, 560, 30));
 }
 
 void drawWin() {
   background(scape);
   
   //draw 'level complete' and box
   fill(0);
   rectMode(CORNER);
   rect(0, 260, 1200, 100);
   fill(255);
   textFont(cyber);
   text("Level Complete!", 180, 335);
   
   //draw buttons and banner
   fill(0);
   rect(0, 525, 1200, 50);
   
   for(int i = 0; i < win.size(); i++) {
     win.get(i).drawButton();
     win.get(i).checkHover();
   } 
 }
 
 void drawLose() {
   background(scape);
   
   //draw 'you lose' text and box
   fill(0);
   rectMode(CORNER);
   rect(0, 260, 1200, 100);
   fill(255);
   textFont(cyber);
   text("You Were Caught!", 140, 335);
   
   //draw buttons and banner
   fill(0);
   rect(0, 525, 1200, 50);
   
   for(int i = 0; i < lose.size(); i++) {
     lose.get(i).drawButton();
     lose.get(i).checkHover();
   } 
 }
 
 void handleMouseLose() {
   //play again is pressed
   if(mouseX > 50 && mouseX < 350 && mouseY > 525 && mouseY < 575) {
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
   //return to menu is pressed
   if(mouseX > 450 && mouseX < 750 && mouseY > 525 && mouseY < 575) {
     state.MenuState = menuState.MAIN;
     state.state = State.FRONTEND;
   }
   //quit is pressed
   if(mouseX > 850 & mouseX < 1150 && mouseY > 525 && mouseY < 575) {
     exit();
   }
 }
 
 void handleMouseWin() {
   //next level is pressed
   if(mouseX > 50 && mouseX < 350 && mouseY > 525 && mouseY < 575) {
     switch(currentLevel) {
       case 1:
         currentLevel = 2;
         level = new Level("Levels/Level_2/level2.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 2:
         currentLevel = 3;
         level = new Level("Levels/Level_3/level3.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 3:
         currentLevel = 4;
         level = new Level("Levels/Level_4/level4.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 4:
         currentLevel = 5;
         level = new Level("Levels/Level_5/level5.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 5:
         currentLevel = 6;
         level = new Level("Levels/Level_6/level6.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 6:
         currentLevel = 7;
         level = new Level("Levels/Level_7/level7.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 7:
         currentLevel = 8;
         level = new Level("Levels/Level_8/level8.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 8:
         currentLevel = 9;
         level = new Level("Levels/Level_9/level9.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 9:
         currentLevel = 10;
         level = new Level("Levels/Level_10/level10.xml", state, paused); 
         state.state = State.INGAME;
         break;
       case 10:
         //not sure what the plan is for the end of game scenario
         break;
     }   
   }
   //return to menu is pressed
   if(mouseX > 450 && mouseX < 750 && mouseY > 525 && mouseY < 575) {
     state.MenuState = menuState.MAIN;
     state.state = State.FRONTEND;
   }
   //quit is pressed
   if(mouseX > 850 & mouseX < 1150 && mouseY > 525 && mouseY < 575) {
     exit();
   }
 }
    
}