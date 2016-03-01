class BlankPiece
{
  int index;
  int x;
  int y;
  boolean contains = false;
  
  BlankPiece(int x, int y, int index)
  {
    this.index = index;
    this.x = x;
    this.y = y;
  }
  
  void drawPiece()
  {
    stroke(0);
    strokeWeight(1);
    fill(255);
    rect(x,y,100,100);
  }
  
  void checkSnap(PartialPiece piece) {
    if(piece.x+50 > x && piece.x+50 < x+100 && piece.y+50 > y && piece.y+50 < y+100) {
      piece.x = x;
      piece.y = y;
    }
  }
  
  void checkProx(PartialPiece piece) {
    if(piece.x+50 > x && piece.x+50 < x+100 && piece.y+50 > y && piece.y+50 < y+100) {
      contains = true;
      //println("contains true");
    } else {
      //println("contains false");
      contains = false;
    }
  }   
}