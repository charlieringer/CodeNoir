class Level
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<LargeObject> desks = new ArrayList<LargeObject>();
  ArrayList<Door> doors = new ArrayList<Door>();
  ArrayList<SmallObject> terminals = new ArrayList<SmallObject>();
  ArrayList<Room> rooms = new ArrayList<Room>();
  ArrayList<SecurityCamera> secCams = new ArrayList<SecurityCamera>();
  ArrayList<Guard> guards = new ArrayList<Guard>();
  Player player;

  LevelState levelState;

  Terminal currTerminal;
  LockPuzzle currLock;
  //Current ServerPuzzle
  //Current FingerPritnPuzzle
  //Current Lock Puzzle
  //Current Camera Puzzle


  boolean gameOver = false;
  StatusBar status = new StatusBar();

  Level() {
    levelState = LevelState.LEVEL;
    walls.add(new Wall(0, 0, width, 20));
    walls.add(new Wall(0, 580, width, 600));
    walls.add(new Wall(0, 0, 20, 600));
    walls.add(new Wall(width-20, 0, width, 600));

    walls.add(new Wall(240, 130, 260, 600));
    walls.add(new Wall(660, 160, 680, 600));
    walls.add(new Wall(width-120, 160, width-100, 600));

    walls.add(new Wall(240, 160, 410, 180));
    walls.add(new Wall(490, 160, 830, 180));
    walls.add(new Wall(910, 160, 1110, 180));
    walls.add(new Wall(1170, 160, 1200, 180));

    walls.add(new Wall(240, 0, 260, 50));
    walls.add(new Wall(830, 400, 900, 470));

    desks.add(new Desk( 60, 120, 160, 140));

    desks.add(new Desk( 320, 260, 420, 280));
    desks.add(new Desk( 320, 360, 420, 380));
    desks.add(new Desk( 320, 460, 420, 480));
    desks.add(new Desk( 320, 560, 420, 580));

    desks.add(new Desk( 520, 260, 620, 280));
    desks.add(new Desk( 520, 360, 620, 380));
    desks.add(new Desk( 520, 460, 620, 480));
    desks.add(new Desk( 520, 560, 620, 580));

    doors.add(new Door( 240, 50, 'v', 't', this));
    doors.add(new Door( 830, 160, 'h', 'l', this, 4));

    rooms.add(new Room(0, 0, 250, 600));
    rooms.add(new Room(249, 0, 1200, 171));
    rooms.add(new Room(250, 170, 670, 600));
    rooms.add(new Room(670, 170, 1100, 600));
    rooms.add(new Room(1100, 170, 1200, 600));

    guards.add(new Guard(360, 220, 'l', 'b'));
    guards.add(new Guard(360, 310, 'r', 'b'));
    guards.add(new Guard(360, 400, 'l', 'b'));
    guards.add(new Guard(360, 500, 'r', 'b'));
    guards.add(new Guard(840, 220, 'l', 'b'));
    guards.add(new Guard(840, 340, 'r', 'b'));
    guards.add(new Guard(840, 540, 'l', 'l'));


    secCams.add(new SecurityCamera(700, 20, 500, 160, 900, 160, 700, 20));
    player = new Player(walls, desks, doors, guards);

    terminals.add(new TerminalObj(85, 120, 105, 140, 4, 4, this, doors.get(0)));
    terminals.add(new TerminalObj(355, 560, 375, 580, 4, 4, this, secCams.get(0)));
  }

  void drawLevel()
  { 
    switch(levelState)
    {
    case LEVEL:
      drawOuterLevel();
      break;
    case TERMINAL:
      assert(currTerminal != null);
      currTerminal.drawTerminal();
      break;
    case FINGERPRINT:
      break;
    case LOCKPICK:
      currLock.drawPuzzle();
      break;
    case CAMERA:
      break;
    case SERVER:
      break;
    }
  }

  void drawOuterLevel()
  {
    background(200);

    for (int i = 0; i < walls.size (); i++) { 
      walls.get(i).drawWall();
    }
    for (int i = 0; i < desks.size (); i++) { 
      desks.get(i).drawObj();
    }
    for (int i = 0; i < doors.size (); i++) { 
      doors.get(i).drawObj();
    }
    for (int i = 0; i < terminals.size (); i++) { 
      terminals.get(i).drawObj();
    }
    for (int i = 0; i < secCams.size (); i++) { 
      secCams.get(i).drawCamera(); 
      if (secCams.get(i).checkForPlayer(player)) gameOver = true;
    }
    player.updateAndDraw();
    for (int i = 0; i < guards.size(); i++) { 
      guards.get(i).moveandDrawGuard(walls, desks); 
      if (!gameOver) gameOver = guards.get(i).checkForPlayer(player, walls);
    }

    player.checkVision(rooms);
    checkPlayerAdjacency();
    if (gameOver) state = State.POSTGAMELOSE;
  }


  void checkPlayerAdjacency()
  {
    int playerSX = player.posX;
    int playerSY = player.posY;
    int playerEX = playerSX+30;
    int playerEY = playerSY+30;

    for (int i = 0; i < doors.size (); i++) 
    { 
      if ( doors.get(i).locked)
      {
        int doorSX = doors.get(i).startX;
        int doorSY = doors.get(i).startY;
        int doorEX = doors.get(i).endX;
        int doorEY = doors.get(i).endY;
        if ((playerSX == doorEX  && playerSY < doorEY && playerEY > doorSY) || 
          (playerSY == doorEY+1  && playerSX < doorEX && playerEX > doorSX) || 
          (playerEX == doorSX  && playerSY < doorEY && playerEY > doorSY) || 
          (playerEY == doorSY && playerSX < doorEX && playerEX > doorSX))
        {
          if (doors.get(i).doorType == 't')
          {
            status.drawStatusBar("Door (locked) - Find terminal to unlock");
          } else if (doors.get(i).doorType == 'l')
          {
            status.drawStatusBar("Locked Door - press SPACE to pick lock");
          } else if (doors.get(i).doorType == 'f')
          {
            status.drawStatusBar("Locked Door - Find fingerprint to unlock");
          }
          return;
        }
      }
    }
    for (int i = 0; i < terminals.size (); i++) 
    { 

      int termSX = terminals.get(i).startX;
      int termSY = terminals.get(i).startY;
      int termEX = terminals.get(i).endX;
      int termEY = terminals.get(i).endY;

      if ((playerSX == termEX && playerSY < termEY && playerEY > termSY) || 
        (playerSY == termEY && playerSX < termEX && playerEX > termSX) || 
        (playerEX == termSX && playerSY < termEY && playerEY > termSY) || 
        (playerEY == termSY && playerSX < termEX && playerEX > termSX))
      {
        status.drawStatusBar("Terminal - press SPACE to use");
        return;
      }
    }
    status.drawStatusBar("");
  }

  void handleKeyOn()
  {
    switch(levelState)
    {
    case LEVEL:
      outerLevelKeyOn();
      break;
    case TERMINAL:
      currTerminal.checkKey();
      break;
    case FINGERPRINT:
      break;
    case LOCKPICK:
      currLock.pressed();
      break;
    case CAMERA:
      break;
    case SERVER:
      break;
    }
  }

  void handleKeyOff()
  {
    switch(levelState)
    {
    case LEVEL:
      player.handleKey(false);
      break;
    case TERMINAL:
      break;
    case FINGERPRINT:
      break;
    case LOCKPICK:
      currLock.released();
      break;
    case CAMERA:
      break;
    case SERVER:
      break;
    }
    
  }


  void outerLevelKeyOn()
  {
    //We have pressed the interact button
    if (key == ' ')
    {
      int playerSX = player.posX;
      int playerSY = player.posY;
      int playerEX = playerSX+30;
      int playerEY = playerSY+30;
      for (int i = 0; i < doors.size (); i++) 
      { 
        if ( doors.get(i).locked && doors.get(i).doorType == 'l')
        {
          int doorSX = doors.get(i).startX;
          int doorSY = doors.get(i).startY;
          int doorEX = doors.get(i).endX;
          int doorEY = doors.get(i).endY;
          if ((playerSX == doorEX  && playerSY < doorEY && playerEY > doorSY) || 
            (playerSY == doorEY+1  && playerSX < doorEX && playerEX > doorSX) || 
            (playerEX == doorSX  && playerSY < doorEY && playerEY > doorSY) || 
            (playerEY == doorSY && playerSX < doorEX && playerEX > doorSX))
          {
            assert(doors.get(i).doorLock  != null);
            currLock = doors.get(i).doorLock ;
            levelState = LevelState.LOCKPICK;
            return;
          }
        }
      }
      for (int i = 0; i < terminals.size (); i++) 
      { 

        int termSX = terminals.get(i).startX;
        int termSY = terminals.get(i).startY;
        int termEX = terminals.get(i).endX;
        int termEY = terminals.get(i).endY;

        if ((playerSX == termEX && playerSY < termEY && playerEY > termSY) || 
          (playerSY == termEY && playerSX < termEX && playerEX > termSX) || 
          (playerEX == termSX && playerSY < termEY && playerEY > termSY) || 
          (playerEY == termSY && playerSX < termEX && playerEX > termSX))
        {
          assert(terminals.get(i).linkedTerm != null);
          currTerminal = terminals.get(i).linkedTerm;
          levelState = LevelState.TERMINAL;
          return;
        }
      }
    }
    player.handleKey(true);
  }
}