PrintPuzzle puzzle; 

void setup()
{
  size(1200,620);
  puzzle = new PrintPuzzle();
}

void draw()
{
  puzzle.drawPuzzle();
}

void mousePressed() {
  puzzle.move();
}

void mouseDragged() {
  puzzle.draggedPiece();
}

void mouseReleased() {
  puzzle.snapPiece();
}