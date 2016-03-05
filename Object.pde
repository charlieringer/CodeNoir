private class Object
{
  PImage displayImage;
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

class MiscObject extends LargeObject
{
  MiscObject(int newSX, int newSY, int newEX, int newEY, String displayPath)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    displayImage = loadImage(displayPath);
  }
  
  void drawObj()
  {
    fill(0, 60, 15);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
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
  //PImage dispImage = loadImage("Art_Assets/In_Game/Levels/testComp.png");
  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, String data)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, data);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, SecurityCamera linkedCam)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedCam);
    assert(linkedTerm != null);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, String data)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, data);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, SecurityCamera linkedCam)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, linkedCam);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, SecurityCamera linkedCam, String data)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedCam, data);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, SecurityCamera linkedCam, String data)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, linkedCam, data);
  }
  void drawObj()
  {
    fill(128);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
    //image(dispImage,startX,startY);
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

class MugObject extends SmallObject
{
  Door linkedDoor;
  PrintPuzzle linkedPuzzle;
  
  MugObject(int sX, int sY, Door door,Level parentLevel)
  {
    linkedDoor = door;
    level = parentLevel;
    startX = sX;
    startY = sY;
    linkedPuzzle = new PrintPuzzle();
  }
  
  void displayInGame()
  {
    fill(255);
    rectMode(CORNERS);
    rect(startX+5, startY+5, startX+10, startY+10);
  }

  void displayOnOwn()
  {
    linkedPuzzle.drawPuzzle();
  }
  
  void pressed()
  {
    if (key == TAB)
    {
      if (linkedPuzzle.completed) linkedDoor.hasFingerPrint = true;
      level.levelState = LevelState.LEVEL;
    }
  }
  
  void handleMousePressed()
  {
    linkedPuzzle.move();
  }
  
  void handleMouseReleased()
  {
    linkedPuzzle.snapPiece();
  }
  
  void handleMouseDragged()
  {
    linkedPuzzle.draggedPiece();
  }
}