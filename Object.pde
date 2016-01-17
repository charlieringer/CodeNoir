private class Object
{
  boolean locked;
  int startX;
  int startY;
  int endX;
  int endY;

  Object() {
  }
  void drawObj() {
  }
}

class LargeObject extends Object { 
  LargeObject() {
  }
}
class SmallObject extends Object { 
  Terminal linkedTerm; 
  SmallObject() {
  }
}

class Desk extends LargeObject
{
  Desk(int newSX, int newSY, int newEX, int newEY)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
  }

  void drawObj()
  {
    fill(128, 60, 15);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }
}



class TerminalObj extends SmallObject
{
  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, int difficulty, Level level, Door linkedDoor)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, difficulty, level, linkedDoor);
    assert(linkedTerm != null);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, int difficulty, Level level, SecurityCamera linkedCam)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, difficulty, level, linkedCam);
    assert(linkedTerm != null);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, int difficulty, Level level)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, difficulty, level);
    assert(linkedTerm != null);
  }

  void drawObj()
  {
    fill(128);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }
}