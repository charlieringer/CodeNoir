class PartialPiece {
  PImage partial;
  int x;
  int y;
  int reset_x;
  int reset_y;
  boolean clicked = false;
  boolean hover = false;
  
  PartialPiece(int x, int y, String name) {
    this.x = x;
    this.y = y;
    reset_x = x;
    reset_y = y;
    partial = loadImage("Art_Assets/In_Game/Fingerprint/select" + name);
    partial.resize(100, 100);
  }
  
  void drawPiece() {
    image(partial, x, y);
    if(mouseX > x && mouseX < x+100 && mouseY > y && mouseY < y + 100) {
      hover = true;
      if(!clicked) {
        stroke(255);
        strokeWeight(3);
        fill(0, 0);
        rect(x, y, 97, 97);
      }
    } else {
      hover = false;
    }
  }
  
  boolean checkMove() {
    if(hover) {
      clicked = true;
      return true;
      //println("test");
      //x = pos_x;
      //y = pos_y;
    } else {
       clicked = false;
       return false;
    }
  }
  
  void dragged() {
    if(clicked) {
      x = mouseX-50;
      y = mouseY-50;
    } 
  }
  
  void reset() {
    x = reset_x;
    y = reset_y;
  }
}