class Server
{
  int sX, sY, eX, eY;
  ServerPuzzle puzzle;
  Level parentLevel;
  
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
      if (!parentLevel.player.hasData) parentLevel.player.hasData = true;
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