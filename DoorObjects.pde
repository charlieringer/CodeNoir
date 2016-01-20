//This is for the in game doors. Probably needs more work when there are more elements in 

class Door extends LargeObject
{
  char orientaion; 
  char doorType; //l = lockpick, t = terminal, f = fingerprint
  int lengthOfTumbler;
  Level parentLevel;
  
  LockPuzzle doorLock;
  Door(int newSX, int newSY, char orient, char type, Level parentLevel, int tumblerLength)
  {
    this.parentLevel = parentLevel;
    if (tumblerLength != 0)
    {
     doorLock = new LockPuzzle(tumblerLength, this, parentLevel); 
    }
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
    doorType = type;
  }
  Door(int newSX, int newSY, char orient, char type, Level parentLevel)
  {
    this( newSX,  newSY,  orient,  type, parentLevel, 0);
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