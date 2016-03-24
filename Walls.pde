class Wall
{
  int startX;
  int startY;
  int endX;
  int endY;

  Wall(int newSX, int newSY, int newEX, int newEY)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
  }

  void drawWall()
  {
    fill(0);
    noStroke();
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }
}