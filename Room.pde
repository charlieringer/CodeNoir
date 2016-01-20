class Room
{
  int startX, startY, endX, endY;

  Room(int sX, int sY, int eX, int eY)
  {
    startX = sX;
    startY = sY;
    endX = eX;
    endY = eY;
  }
  void blackout()
  {
    fill(0, 200);
    rectMode(CORNERS);
    noStroke();
    rect(startX, startY, endX, endY);
  }
}