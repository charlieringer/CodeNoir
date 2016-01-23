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
  
    TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, int difficulty, Level level, Door linkedDoor, String data)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, difficulty, level, linkedDoor, data);
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

  void drawObj()
  {
    fill(128);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }
}

class PapersObject extends SmallObject
{
  StringList dataList = new StringList();
  int x, y;
  Level level;

  PapersObject(int x, int y, String path, Level parentLevel)
  {
    level = parentLevel;
    this.x = x;
    this.y = y;

    String data[] = loadStrings(path);

    int count = 0;
    if (data.length > 0)
    {
      for (String line : data) {
        dataList.append(line);
      }
    }
  }

  void displayInGame()
  {
    fill(255);
    rectMode(CORNERS);
    rect(x, y, x+20, y+20);
  }

  void displayOnOwn()
  {
    fill(255);
    rect(100, 50, width-100, height-50);
    fill(0);
    for (int i = 0; i < dataList.size(); i++)
    {
      text(dataList.get(i), 150, 50*i);
    }
  }

  void pressed()
  {
    if (key == TAB)
    {
      level.levelState = LevelState.LEVEL;
    }
  }
}