class GameFinished extends Level
{
  PImage newsPaper;
  PFont font;
  StateClass state;
  
  
  GameFinished(String newsPaperPath, StateClass state)
  {
    newsPaper = loadImage(newsPaperPath);
    this.state = state;
    font = createFont("Fonts/renegado.ttf", 130);
    textFont(font);
  }
  void drawLevel()
  {
    background(0);
    fill(255);
    textAlign(CENTER);
    textFont(font);
    text("game over", width/2, 100);
    image(newsPaper, (width/2)-190, 150);
    textSize(20);
    text("Click or press any key to return to the main menu", width/2, 500);
    
  }
  
  void handleKeyOn(){
    textAlign(LEFT);
    state.state = State.FRONTEND;
    
  }
  void handleKeyOff(){
  }
  void handleMousePressed(){
    textAlign(LEFT);
    state.state = State.FRONTEND;
  }
  void handleMouseReleased(){
  }
  void handleMouseDragged(){
  }
}