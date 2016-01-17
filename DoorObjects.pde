//This is for the in game doors. Probably needs more work when there are more elements in 

class Door extends LargeObject
{
  char orientaion; 
  Door(int newSX, int newSY, char orient)
  {
    if ((orientaion = orient) == 'v')
    {
      startX = newSX;
      startY = newSY;
      endX = startX+20;
      endY = startY+80;
    } else {
      startX = newSX;
      startY = newSY;
      endX = startX+80;
      endY = startY+20;
    }
    locked = true;
  }
  void drawObj()
  {
    fill(128, 60, 15);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }

  void open()
  {
    locked = false;
    if (orientaion == 'v')
    {
      endY = startY+20;
    } else {
      endX = startX+20;
    }
  }
}