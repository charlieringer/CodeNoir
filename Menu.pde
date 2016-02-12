class Menu {
 menuState MenuState;
 initialScreen screen;
 mainMenu mainScreen;
 Controls controls;
 Settings settings;
 boolean playNew = false;
 
 Menu() {
   MenuState = menuState.INITIAL;
   screen = new initialScreen();
   mainScreen = new mainMenu();
   controls = new Controls();
   settings = new Settings();
 } 
  
 void drawMenu() {   
   switch(MenuState) {
     case INITIAL:
       screen.drawInitial();
       break;
     case MAIN:
       mainScreen.drawMain();
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
   switch(MenuState) {
     case INITIAL:
       if(key == ' ') {
         MenuState = menuState.MAIN;
       }
       break;
   }
 }
 
 void handleMouse() {
    switch(MenuState) {
      case INITIAL:
        break;
      case MAIN:
        //new game is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 100 && mouseY < 150) {
          playNew = true;
        }
    
        //continue game is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 200 && mouseY < 250) {
          //MenuState = menuState.CONTINUEMENU;
        }
    
        //controls is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 300 && mouseY < 350) {
          MenuState = menuState.CONTROLS;
        }
    
        //settings is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 400 && mouseY < 450) {
          MenuState = menuState.SETTINGS;
        }
    
        //quit is pressed
        if(mouseX > 750 && mouseX < 1050 && mouseY > 500 && mouseY < 550) {
          exit();
        }
        break;
      case CONTROLS:
        //home button is pressed
        if(mouseX > 1095 && mouseX < 1180 && mouseY > 20 && mouseY < 105) {
          MenuState = menuState.MAIN;
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
          MenuState = menuState.MAIN;
        }
        break;
    }
 }
 
  
  
}