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
    //rect(startX, startY, endX, endY);
    image(displayImage, startX, startY);
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
  PImage dispImage;
  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, String data, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, data);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, SecurityCamera linkedCam, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedCam);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
    assert(linkedTerm != null);
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, String data, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, data);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, SecurityCamera linkedCam, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, linkedCam);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, SecurityCamera linkedCam, String data, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedCam, data);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }

  TerminalObj(int newSX, int newSY, int newEX, int newEY, int codeLength, Level level, Door linkedDoor, SecurityCamera linkedCam, String data, int rotate)
  {
    startX = newSX;
    startY = newSY;
    endX = newEX;
    endY = newEY;
    linkedTerm = new Terminal(codeLength, level, linkedDoor, linkedCam, data);
    dispImage  = loadImage("Art_Assets/In_Game/Levels/Computer/"+rotate+".png");
  }
  void drawObj()
  {
    image(dispImage,startX,startY);
  }
}

class PapersObject extends SmallObject
{
  PImage dispImage = loadImage("Art_Assets/In_Game/Levels/Papers/0.png");
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
    image(dispImage, x, y);
  }

  void displayOnOwn()
  {
    fill(255);
    rect(100, 50, width-100, height-50);
    textSize(20);
    fill(0);
    for (int i = 0; i < dataList.size(); i++)
    {
      text(dataList.get(i), 150, 50*i+100);
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
  PImage dispImage;
  
  MugObject(int sX, int sY, Door door,Level parentLevel)
  {
    linkedDoor = door;
    level = parentLevel;
    startX = sX;
    startY = sY;
    linkedPuzzle = new PrintPuzzle();
    dispImage = loadImage("Art_Assets/In_Game/Levels/Mug/0.png");
  }
  
  void displayInGame()
  {
    image(dispImage, startX+4, startY+4);
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