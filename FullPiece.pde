class FullPiece {
  PImage full_print;
  int x;
  int y;
  
  FullPiece(int x, int y, String name) {
    this.x = x;
    this.y = y;
    full_print = loadImage(name);
    full_print.resize(200, 300);
  }
  
  void drawPiece() {
    image(full_print, x, y);
  } 
}