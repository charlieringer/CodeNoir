//This is for the in game doors. Probably needs more work when there are more elements in 

class Door extends LargeObject
{
  String orientaion; 
  String doorType; //l = lockpick, t = terminal, f = fingerprint
  int lengthOfTumbler;
  boolean hasFingerPrint = false;
  Level parentLevel;
  PImage lockedImage;
  PImage unlockedImage;
  PImage unlockedShort;

  LockPuzzle doorLock;
  Door(int newSX, int newSY, String orient, String type, Level parentLevel, int tumblerLength)
  {
    this.parentLevel = parentLevel;
    if (tumblerLength != 0)
    {
      doorLock = new LockPuzzle(tumblerLength, this, parentLevel);
    }
    if ((orientaion = orient).equals("v"))
    {
      if (tumblerLength != 0)
      {
        lockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenV.png");
        unlockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenV.png");
        unlockedShort = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenOpenV.png");
      } else {
        lockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/LockedV.png");
        unlockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/UnlockedV.png");
        unlockedShort = loadImage("Art_Assets/In_Game/Levels/Doors/OpenV.png");
      }

      startX = newSX;
      startY = newSY;
      endX = startX+20;
      endY = startY+80;
    } else {
      if (tumblerLength != 0)
      {
        lockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenH.png");
        unlockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenH.png");
        unlockedShort = loadImage("Art_Assets/In_Game/Levels/Doors/WoodenOpenH.png");
      } else {
        lockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/LockedH.png");
        unlockedImage = loadImage("Art_Assets/In_Game/Levels/Doors/UnlockedH.png");
        unlockedShort = loadImage("Art_Assets/In_Game/Levels/Doors/OpenH.png");
      }
      startX = newSX;
      startY = newSY;
      endX = startX+80;
      endY = startY+20;
    }
    locked = true;
    doorType = type;
  }
  Door(int newSX, int newSY, String orient, String type, Level parentLevel)
  {
    this( newSX, newSY, orient, type, parentLevel, 0);
  }
  void drawObj()
  {
    fill(128, 60, 15);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
    if (locked)
    {
      image(lockedImage, startX, startY);
    } else {
      image(unlockedShort, startX, startY);
    }
  }

  void open()
  {
    locked = false;
    if (orientaion.equals("v"))
    {
      endY = startY+20;
    } else {
      endX = startX+20;
    }
  }

  void close()
  {
    locked = true;
    if (orientaion.equals("v"))
    {
      endY = startY+80;
    } else {
      endX = startX+80;
    }
  }
}