class Level
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<LargeObject> desks = new ArrayList<LargeObject>();
  ArrayList<Door> doors = new ArrayList<Door>();
  ArrayList<SmallObject> terminals = new ArrayList<SmallObject>();
  ArrayList<Room> rooms = new ArrayList<Room>();
  ArrayList<SecurityCamera> secCams = new ArrayList<SecurityCamera>();
  ArrayList<Guard> guards = new ArrayList<Guard>();
  ArrayList<PapersObject> papers = new ArrayList<PapersObject>();
  Player player;
  Server server;
  Endpoint end;

  LevelState levelState;

  Terminal currTerminal;
  LockPuzzle currLock;
  PapersObject currPapers;
  //Current FingerPritnPuzzle
  //Current Camera Puzzle


  boolean gameOver = false;
  StatusBar status = new StatusBar();

  Level(String levelDataPath) {
    levelState = LevelState.LEVEL;

    XML level = loadXML(levelDataPath);

    XML[] wallXML = level.getChildren("wall");
    for (int i = 0; i < wallXML.length; i++) {
      int sX = wallXML[i].getInt("sX");
      int sY = wallXML[i].getInt("sY");
      int eX = wallXML[i].getInt("eX");
      int eY = wallXML[i].getInt("eY");
      walls.add(new Wall(sX, sY, eX, eY));
    }

    XML[] roomXML = level.getChildren("room");
    for (int i = 0; i < roomXML.length; i++) {
      int sX = roomXML[i].getInt("sX");
      int sY = roomXML[i].getInt("sY");
      int eX = roomXML[i].getInt("eX");
      int eY = roomXML[i].getInt("eY");
      rooms.add(new Room(sX, sY, eX, eY));
    }

    XML[] deskXML = level.getChildren("desk");
    for (int i = 0; i < deskXML.length; i++) {
      int sX = deskXML[i].getInt("sX");
      int sY = deskXML[i].getInt("sY");
      int eX = deskXML[i].getInt("eX");
      int eY = deskXML[i].getInt("eY");
      desks.add(new Desk(sX, sY, eX, eY));
    }

    XML[] guardXML = level.getChildren("guard");
    for (int i = 0; i < guardXML.length; i++) {
      int sX = guardXML[i].getInt("sX");
      int sY = guardXML[i].getInt("sY");
      String facing = guardXML[i].getString("startingOrientation");
      String turning = guardXML[i].getString("onCollisionTurn");
      guards.add(new Guard(sX, sY, facing, turning));
    }

    XML[] papersXML = level.getChildren("paper");
    for (int i = 0; i < papersXML.length; i++) {
      int sX = papersXML[i].getInt("sX");
      int sY = papersXML[i].getInt("sY");
      String dataPath = papersXML[i].getString("dataPath");
      papers.add(new PapersObject(sX, sY, dataPath, this));
    }

    XML[] cameraXML = level.getChildren("camera");
    for (int i = 0; i < cameraXML.length; i++)
    {
      int p1X = cameraXML[i].getInt("pointOneX");
      int p1Y = cameraXML[i].getInt("pointOneY");
      int p2X = cameraXML[i].getInt("pointTwoX");
      int p2Y = cameraXML[i].getInt("pointTwoY");
      int p3X = cameraXML[i].getInt("pointThreeX");
      int p3Y = cameraXML[i].getInt("pointThreeY");
      int camX = cameraXML[i].getInt("cameraPointX");
      int camY = cameraXML[i].getInt("cameraPointY");
      secCams.add(new SecurityCamera(p1X, p1Y, p2X, p2Y, p3X, p3Y, camX, camY));
    }

    XML serverXML = level.getChild("server");
    int sX = serverXML.getInt("sX");
    int sY = serverXML.getInt("sY");
    int eX = serverXML.getInt("eX");
    int eY = serverXML.getInt("eY");
    String lvl = serverXML.getString("level");
    String win = serverXML.getString("solution");
    walls.add(new Wall(sX, sY, eX, eY));
    server = new Server(sX, sY, eX, eY, this, lvl, win);

    XML endXML = level.getChild("end");
    sX = endXML.getInt("sX");
    sY = endXML.getInt("sY");
    eX = endXML.getInt("eX");
    eY = endXML.getInt("eY");
    end = new Endpoint(sX, sY, eX, eY);

    XML[] doorXML = level.getChildren("door");
    for (int i = 0; i < doorXML.length; i++)
    {
      int x = doorXML[i].getInt("sX");
      int y = doorXML[i].getInt("sY");
      String orientation = doorXML[i].getString("orientation");
      String lockType = doorXML[i].getString("locktype");
      if (doorXML[i].hasAttribute("pins"))
      {
        int pins = doorXML[i].getInt("pins");
        doors.add(new Door( x, y, orientation, lockType, this, pins));
      } else {
        doors.add(new Door( x, y, orientation, lockType, this));
      }
    }

    XML[] terminalXML = level.getChildren("terminal");
    for (int i = 0; i < terminalXML.length; i++)
    {
      boolean hasConnectedDoor = false;
      boolean hasConnectedCam = false;
      boolean hasConnectedData = false;
      int tsX = terminalXML[i].getInt("sX");
      int tsY = terminalXML[i].getInt("sY");
      int teX = tsX+20;
      int teY = tsY+20;
      int codeLength = terminalXML[i].getInt("codeLength");

      if  (terminalXML[i].hasAttribute("connectedDoorID")) hasConnectedDoor = true;
      if  (terminalXML[i].hasAttribute("connectedCamID")) hasConnectedCam = true;
      if  (terminalXML[i].hasAttribute("connectedDataPath")) hasConnectedData = true;

      if (hasConnectedDoor && !hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor));
      } else if (!hasConnectedDoor && hasConnectedCam && !hasConnectedData)
      {
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedCam));
      } else if (!hasConnectedDoor && !hasConnectedCam && hasConnectedData)
      {
        String dataPath = terminalXML[i].getString("connectedData");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, dataPath));
      } else if (hasConnectedDoor && hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, linkedCam));
      } else if (hasConnectedDoor && !hasConnectedCam && hasConnectedData)
      {
        
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        String dataPath = terminalXML[i].getString("connectedDataPath");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, dataPath));
      } else if (!hasConnectedDoor && hasConnectedCam && hasConnectedData)
      {
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        String dataPath = terminalXML[i].getString("connectedData");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedCam, dataPath));
      } else if (hasConnectedDoor && !hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        String dataPath = terminalXML[i].getString("connectedData");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, linkedCam, dataPath));
      }
    }

    player = new Player(walls, desks, doors, guards);
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
      server.drawOnOwn();
      break;
    case PAPERS:
      currPapers.displayOnOwn();
      break;
    }
  }

  void drawOuterLevel()
  {
    background(200);

    for (Wall wall : walls) { 

      wall.drawWall();
    }
    for (LargeObject desk : desks) { 
      desk.drawObj();
    }
    for (LargeObject door : doors) { 
      door.drawObj();
    }
    for (SmallObject terminal : terminals) { 
      terminal.drawObj();
    }
    for (PapersObject paper : papers) {
      paper.displayInGame();
    }
    for (SecurityCamera secCam : secCams) { 
      secCam.drawCamera(); 
      if (secCam.checkForPlayer(player)) gameOver = true;
    }
    for (Guard guard : guards)
    {
      guard.moveandDrawGuard(walls, desks);
      if (!gameOver) gameOver = guard.checkForPlayer(player, walls);
    }


    server.drawOnLevel();
    end.drawEndpoint();
    player.updateAndDraw();
    player.checkVision(rooms);
    checkPlayerAdjacency();
    if (gameOver) state.state = State.POSTGAMELOSE;
    if (end.levelCompleted(player)) state.state = State.POSTGAMEWIN;
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
          if (doors.get(i).doorType.equals("t"))
          {
            status.drawStatusBar("Door (locked) - Find terminal to unlock");
          } else if (doors.get(i).doorType.equals("l"))
          {
            status.drawStatusBar("Locked Door - press SPACE to pick lock");
          } else if (doors.get(i).doorType.equals("f"))
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

    for (int i = 0; i < papers.size (); i++) 
    { 

      int papersSX = papers.get(i).x;
      int papersSY = papers.get(i).y;
      int papersEX = papersSX+20;
      int papersEY = papersSY+20;

      if ((playerSX == papersEX && playerSY < papersEY && playerEY > papersSY) || 
        (playerSY == papersEY && playerSX < papersEX && playerEX > papersSX) || 
        (playerEX == papersSX && playerSY < papersEY && playerEY > papersSY) || 
        (playerEY == papersSY && playerSX < papersEX && playerEX > papersSX))
      {
        status.drawStatusBar("Papers - press SPACE to read");
        return;
      }
    }

    int serverSX = server.sX;
    int serverSY = server.sY;
    int serverEX = server.eX;
    int serverEY = server.eY;

    if ((playerSX == serverEX && playerSY < serverEY && playerEY > serverSY) || 
      (playerSY == serverEY && playerSX < serverEX && playerEX > serverSX) || 
      (playerEX == serverSX && playerSY < serverEY && playerEY > serverSY) || 
      (playerEY == serverSY && playerSX < serverEX && playerEX > serverSX))
    {
      status.drawStatusBar("Server - press SPACE to download data");
      return;
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
    case PAPERS:
      currPapers.pressed();
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
      server.handleKey();
      break;
    case PAPERS:
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
        if ( doors.get(i).locked && doors.get(i).doorType.equals("l"))
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

      for (int i = 0; i < papers.size (); i++) 
      { 

        int papersSX = papers.get(i).x;
        int papersSY = papers.get(i).y;
        int papersEX = papersSX+20;
        int papersEY = papersSY+20;

        if ((playerSX == papersEX && playerSY < papersEY && playerEY > papersSY) || 
          (playerSY == papersEY && playerSX < papersEX && playerEX > papersSX) || 
          (playerEX == papersSX && playerSY < papersEY && playerEY > papersSY) || 
          (playerEY == papersSY && playerSX < papersEX && playerEX > papersSX))
        {
          levelState = LevelState.PAPERS;
          currPapers = papers.get(i);
          return;
        }
      }

      int serverSX = server.sX;
      int serverSY = server.sY;
      int serverEX = server.eX;
      int serverEY = server.eY;

      if ((playerSX == serverEX && playerSY < serverEY && playerEY > serverSY) || 
        (playerSY == serverEY && playerSX < serverEX && playerEX > serverSX) || 
        (playerEX == serverSX && playerSY < serverEY && playerEY > serverSY) || 
        (playerEY == serverSY && playerSX < serverEX && playerEX > serverSX))
      {
        levelState = LevelState.SERVER;
        return;
      }
    }
    player.handleKey(true);
  }

  void handleMousePressed()
  {
    switch(levelState)
    {
    case LEVEL:
      break;
    case TERMINAL:
      break;
    case FINGERPRINT:
      break;
    case LOCKPICK:
      break;
    case CAMERA:
      break;
    case SERVER:
      server.handleMousePressed();
      break;
    case PAPERS:
      break;
    }
  }
}