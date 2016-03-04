class Level
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<LargeObject> hardObjects = new ArrayList<LargeObject>();
  ArrayList<Door> doors = new ArrayList<Door>();
  ArrayList<SmallObject> terminals = new ArrayList<SmallObject>();
  ArrayList<Room> rooms = new ArrayList<Room>();
  ArrayList<SecurityCamera> secCams = new ArrayList<SecurityCamera>();
  ArrayList<Guard> guards = new ArrayList<Guard>();
  ArrayList<PapersObject> papers = new ArrayList<PapersObject>();
  Player player;
  ArrayList<Server> servers = new ArrayList<Server>();
  ArrayList<MugObject> mugs = new ArrayList<MugObject>();
  Endpoint end;
  int dataNeeded = 0;

  LevelState levelState;

  Terminal currTerminal;
  LockPuzzle currLock;
  PapersObject currPapers;
  Server currServer;
  MugObject currMug;
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
      hardObjects.add(new Desk(sX, sY, eX, eY));
    }

    XML[] miscXML = level.getChildren("miscObj");
    for (int i = 0; i < miscXML.length; i++) {
      int sX = miscXML[i].getInt("sX");
      int sY = miscXML[i].getInt("sY");
      int eX = miscXML[i].getInt("eX");
      int eY = miscXML[i].getInt("eY");
      String imgPath = miscXML[i].getString("displayImage");
      hardObjects.add(new MiscObject(sX, sY, eX, eY, imgPath));
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

    XML[] serverXML = level.getChildren("server");
    for (int i = 0; i < serverXML.length; i++)
    {
      int sX = serverXML[i].getInt("sX");
      int sY = serverXML[i].getInt("sY");
      int eX = serverXML[i].getInt("eX");
      int eY = serverXML[i].getInt("eY");
      String lvl = serverXML[i].getString("level");
      String win = serverXML[i].getString("solution");
      walls.add(new Wall(sX, sY, eX, eY));
      servers.add(new Server(sX, sY, eX, eY, this, lvl, win));
    }

    XML endXML = level.getChild("end");
    int sX = endXML.getInt("sX");
    int sY = endXML.getInt("sY");
    int eX = endXML.getInt("eX");
    int eY = endXML.getInt("eY");
    end = new Endpoint(sX, sY, eX, eY, this);

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
    
    XML[] mugXML = level.getChildren("mug");
    for (int i = 0; i < mugXML.length; i++) {
      sX = mugXML[i].getInt("sX");
      sY = mugXML[i].getInt("sY");
      mugs.add(new MugObject(sX, sY, doors.get(0), this));
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
    XML playerXML = level.getChild("player");
    int playerx = playerXML.getInt("sX");
    int playery = playerXML.getInt("sY");
    player = new Player(walls, hardObjects, doors, guards, playerx, playery);

    dataNeeded = level.getChild("dataAmount").getInt("needed");
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
      currMug.displayOnOwn();
      break;
    case LOCKPICK:
      currLock.drawPuzzle();
      break;
    case CAMERA:
      break;
    case SERVER:
      currServer.drawOnOwn();
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
    for (LargeObject obj : hardObjects) { 
      obj.drawObj();
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

    for (MugObject mug : mugs) {
      mug.displayInGame();
    }
    for (SecurityCamera secCam : secCams) { 
      secCam.drawCamera(); 
      if (secCam.checkForPlayer(player)) gameOver = true;
    }
    for (Guard guard : guards)
    {
      guard.moveandDrawGuard(walls, hardObjects);
      if (!gameOver) gameOver = guard.checkForPlayer(player, walls);
    }

    for (Server server : servers)
    {
      server.drawOnLevel();
    }
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
            if(doors.get(i).hasFingerPrint)
            {
              status.drawStatusBar("Locked Door - Fingerprint found, press SPACE to unlock");
            } else 
            {
              status.drawStatusBar("Locked Door - Find fingerprint to unlock");
            }
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
    for (int i = 0; i < servers.size (); i++) 
    { 

      int serverSX = servers.get(i).sX;
      int serverSY = servers.get(i).sY;
      int serverEX = servers.get(i).eX;
      int serverEY = servers.get(i).eY;

      if ((playerSX == serverEX && playerSY < serverEY && playerEY > serverSY) || 
        (playerSY == serverEY && playerSX < serverEX && playerEX > serverSX) || 
        (playerEX == serverSX && playerSY < serverEY && playerEY > serverSY) || 
        (playerEY == serverSY && playerSX < serverEX && playerEX > serverSX))
      {
        status.drawStatusBar("Server - press SPACE to download data");
        return;
      }
    }
    for (int i = 0; i < mugs.size (); i++) 
    { 

      int mugsSX = mugs.get(i).startX;
      int mugsSY = mugs.get(i).startY;
      int mugsEX = mugsSX+20;
      int mugsEY = mugsSY+20;

      if ((playerSX == mugsEX && playerSY < mugsEY && playerEY > mugsSY) || 
        (playerSY == mugsEY && playerSX < mugsEX && playerEX > mugsSX) || 
        (playerEX == mugsSX && playerSY < mugsEY && playerEY > mugsSY) || 
        (playerEY == mugsSY && playerSX < mugsEX && playerEX > mugsSX))
      {
        status.drawStatusBar("Mug - press SPACE to copy fingerprint");
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
      currMug.pressed();
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
      currServer.handleKey();
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
            if (doors.get(i).doorType.equals("l"))
            {
              currLock = doors.get(i).doorLock ;
              levelState = LevelState.LOCKPICK;
              return;
            }
            if(doors.get(i).doorType.equals("f") && doors.get(i).hasFingerPrint)
            {
              doors.get(i).open();
            }
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

      for (int i = 0; i < servers.size (); i++) 
      { 

        int serverSX = servers.get(i).sX;
        int serverSY = servers.get(i).sY;
        int serverEX = servers.get(i).eX;
        int serverEY = servers.get(i).eY;

        if ((playerSX == serverEX && playerSY < serverEY && playerEY > serverSY) || 
          (playerSY == serverEY && playerSX < serverEX && playerEX > serverSX) || 
          (playerEX == serverSX && playerSY < serverEY && playerEY > serverSY) || 
          (playerEY == serverSY && playerSX < serverEX && playerEX > serverSX))
        {
          levelState = LevelState.SERVER;
          currServer = servers.get(i);
          return;
        }
      }
      for (int i = 0; i < mugs.size (); i++) 
      { 

        int mugSX = mugs.get(i).startX;
        int mugSY = mugs.get(i).startY;
        int mugEX = mugSX+20;
        int mugEY = mugSY+20;

        if ((playerSX == mugEX && playerSY < mugEY && playerEY > mugSY) || 
          (playerSY == mugEY && playerSX < mugEX && playerEX > mugSX) || 
          (playerEX == mugSX && playerSY < mugEY && playerEY > mugSY) || 
          (playerEY == mugSY && playerSX < mugEX && playerEX > mugSX))
        {
          levelState = LevelState.FINGERPRINT;
          currMug = mugs.get(i);
          return;
        }
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
      currMug.handleMousePressed();
      break;
    case LOCKPICK:
      break;
    case CAMERA:
      break;
    case SERVER:
      currServer.handleMousePressed();
      break;
    case PAPERS:
      break;
    }
  }
  
  void handleMouseReleased()
  {
    switch(levelState)
    {
    case LEVEL:
      break;
    case TERMINAL:
      break;
    case FINGERPRINT:
      currMug.handleMouseReleased();
      break;
    case LOCKPICK:
      break;
    case CAMERA:
      break;
    case SERVER:
      break;
    case PAPERS:
      break;
    }
  }
  
  void handleMouseDragged()
  {
    switch(levelState)
    {
    case LEVEL:
      break;
    case TERMINAL:
      break;
    case FINGERPRINT:
      currMug.handleMouseDragged();
      break;
    case LOCKPICK:
      break;
    case CAMERA:
      break;
    case SERVER:
      break;
    case PAPERS:
      break;
    }
  }
}

class StatusBar
{
  void drawStatusBar(String status)
  {
    fill(0);
    rect(0, 600, width, 620);
    fill(255);
    text(status, 100, 610);
  }
}