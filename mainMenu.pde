class mainMenu {
  PFont cyber;
  PImage scape;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  mainMenu() {
    cyber = createFont("Fonts/renegado.ttf", 30);
    scape = loadImage("Art_Assets/Frontend/pixels-3.jpeg");
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