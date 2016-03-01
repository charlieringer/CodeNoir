class Server
{
  int sX, sY, eX, eY;
  ServerPuzzle puzzle;
  Level parentLevel;
  boolean complete = false;
  
  Server(int sX, int sY, int eX, int eY, Level parentLevel, String lvl, String win)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
    this.parentLevel = parentLevel;
    puzzle = new ServerPuzzle(lvl, win); 
  }
  
  void drawOnLevel()
  {
    fill(0,255,0);
    rectMode(CORNERS);
    rect(sX, sY, eX, eY);
  }
  
  void drawOnOwn()
  { 
    if(puzzle.gameWin == false) {
      puzzle.drawMaze();
    } else {  
      if(!complete)
      {
        complete = true;
        parentLevel.player.hasData+=1;
      }
      puzzle.win();
    }
  }
  
  void handleKey()
  {
    if (key == TAB)
    {
      parentLevel.levelState = LevelState.LEVEL;
    }
  }
  
  void handleMousePressed()
  {
    puzzle.move();
  }
  
  
}