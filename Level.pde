class Level
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<LargeObject> hardObjects = new ArrayList<LargeObject>();
  ArrayList<Door> doors = new ArrayList<Door>();
  ArrayList<TerminalObj> terminals = new ArrayList<TerminalObj>();
  ArrayList<Room> rooms = new ArrayList<Room>();
  ArrayList<SecurityCamera> secCams = new ArrayList<SecurityCamera>();
  ArrayList<Guard> guards = new ArrayList<Guard>();
  ArrayList<PapersObject> papers = new ArrayList<PapersObject>();
  Player player;
  ArrayList<Server> servers = new ArrayList<Server>();
  ArrayList<MugObject> mugs = new ArrayList<MugObject>();
  Endpoint end;
  int dataNeeded = 0;
  ArrayList<PImage> floorTiles = new ArrayList<PImage>();

  StateClass state;

  LevelState levelState;
  LevelState prevState;

  PauseScreen pause;

  Terminal currTerminal;
  LockPuzzle currLock;
  PapersObject currPapers;
  Server currServer;
  MugObject currMug;
  //Level 5 only
  BrokenWall brokenWall = null;


  boolean gameOver = false;
  StatusBar status = new StatusBar();
  
  Level(){}
  Level(String levelDataPath, StateClass state) { 

    floorTiles.add(loadImage("Art_Assets/In_Game/Levels/Floor/floor1.jpeg"));
    floorTiles.add(loadImage("Art_Assets/In_Game/Levels/Floor/floor2.jpeg"));
    floorTiles.add(loadImage("Art_Assets/In_Game/Levels/Floor/floor3.jpeg"));
    floorTiles.add(loadImage("Art_Assets/In_Game/Levels/Floor/floor4.jpeg"));

    levelState = LevelState.LEVEL;
    this.state = state;

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
      int rotate = cameraXML[i].getInt("rotate");
      secCams.add(new SecurityCamera(p1X, p1Y, p2X, p2Y, p3X, p3Y, camX, camY, rotate));
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
    int rotate = endXML.getInt("rotate");
    end = new Endpoint(sX, sY, eX, eY, this, rotate);

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
      rotate = terminalXML[i].getInt("rotate");
      int codeLength = terminalXML[i].getInt("codeLength");

      if  (terminalXML[i].hasAttribute("connectedDoorID")) hasConnectedDoor = true;
      if  (terminalXML[i].hasAttribute("connectedCamID")) hasConnectedCam = true;
      if  (terminalXML[i].hasAttribute("connectedDataPath")) hasConnectedData = true;

      if (hasConnectedDoor && !hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, rotate));
      } else if (!hasConnectedDoor && hasConnectedCam && !hasConnectedData)
      {
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedCam, rotate));
      } else if (!hasConnectedDoor && !hasConnectedCam && hasConnectedData)
      {
        String dataPath = terminalXML[i].getString("connectedDataPath");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, dataPath, rotate));
      } else if (hasConnectedDoor && hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, linkedCam, rotate));
      } else if (hasConnectedDoor && !hasConnectedCam && hasConnectedData)
      {

        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        String dataPath = terminalXML[i].getString("connectedDataPath");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, dataPath, rotate));
      } else if (!hasConnectedDoor && hasConnectedCam && hasConnectedData)
      {
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        String dataPath = terminalXML[i].getString("connectedDataPath");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedCam, dataPath, rotate));
      } else if (hasConnectedDoor && !hasConnectedCam && !hasConnectedData)
      {
        Door linkedDoor = doors.get(terminalXML[i].getInt("connectedDoorID"));
        SecurityCamera linkedCam = secCams.get(terminalXML[i].getInt("connectedCamID"));
        String dataPath = terminalXML[i].getString("connectedDataPath");
        terminals.add(new TerminalObj(tsX, tsY, teX, teY, codeLength, this, linkedDoor, linkedCam, dataPath, rotate));
      }
    }
    XML playerXML = level.getChild("player");
    int playerx = playerXML.getInt("sX");
    int playery = playerXML.getInt("sY");
    player = new Player(walls, hardObjects, doors, guards, playerx, playery);

    XML brokenWallXML = level.getChild("brokenWall");
    if (brokenWallXML != null)
    {
      sX = brokenWallXML.getInt("sX");
      sY = brokenWallXML.getInt("sY");
      eX = brokenWallXML.getInt("eX");
      eY = brokenWallXML.getInt("eY");
      brokenWall = new BrokenWall(sX, sY, eX, eY, this); 
    }


    dataNeeded = level.getChild("dataAmount").getInt("needed");
    pause = new PauseScreen(this, state);
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
      brokenWall.drawOnOwn();
      break;
    case SERVER:
      currServer.drawOnOwn();
      break;
    case PAPERS:
      currPapers.displayOnOwn();
      break;
    case PAUSE:
      pause.display();
      break;
    }
  }

  void drawOuterLevel()
  {
    drawFloor();
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

      if (!gameOver) gameOver = guard.checkForPlayer(player, walls, doors);
      guard.moveandDrawGuard(walls, hardObjects, doors);
    }

    for (Server server : servers)
    {
      server.drawOnLevel();
    }
    player.updateAndDraw();
    checkPlayerAdjacency();
    if (gameOver) state.state = State.POSTGAMELOSE;
    if (end.levelCompleted(player))
    {
      save.updateLevel(currentLevel);
      save.outputSave();
      state.state = State.POSTGAMEWIN;
    }
    end.drawEndpoint();
    player.checkVision(rooms);
  }

  void drawFloor()
  {
    background(200);
    if (floorTiles.size() ==0)
    {
      return;
    }

    int count = 0;
    for (int i = 0; i < width; i+=99)
    {
      for (int j = 0; j < height; j +=99)
      {
        count++;
        image(floorTiles.get(count%floorTiles.size()), i, j);
      }
    }
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
          (playerSY == doorEY  && playerSX < doorEX && playerEX > doorSX) || 
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
            if (doors.get(i).hasFingerPrint)
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
    if (brokenWall != null)
    {
      int wallSX = brokenWall.startX;
      int wallSY = brokenWall.startY;
      int wallEX = brokenWall.endX;
      int wallEY = brokenWall.endY;

      if ((playerSX == wallEX && playerSY < wallEY && playerEY > wallSY) || 
        (playerSY == wallEY && playerSX < wallEX && playerEX > wallSX) || 
        (playerEX == wallSX && playerSY < wallEY && playerEY > wallSY) || 
        (playerEY == wallSY && playerSX < wallEX && playerEX > wallSX))
      {
        status.drawStatusBar("Cracked wall - press SPACE to feed camera through hole");
        return;
      }
    }
    status.drawStatusBar("");
  }


  void handleKeyOn()
  {
    if (key == 'p')
    {
      if (levelState != LevelState.PAUSE)
      {
        prevState = levelState;
        levelState = LevelState.PAUSE;
        paused = true;
        return;
      } else {
        levelState = prevState;
        paused = false;
        return;
      }
    }
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
      brokenWall.handleKey();
      break;
    case SERVER:
      break;
    case PAPERS:
      currPapers.pressed();
      break;
    case PAUSE:
    }
  }

  void handleKeyOff()
  {
    player.handleKey(false);
    switch(levelState)
    {
    case LEVEL:
      //player.handleKey(false);
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
            if (doors.get(i).doorType.equals("f") && doors.get(i).hasFingerPrint)
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
      if (brokenWall != null)
      {
        int wallSX = brokenWall.startX;
        int wallSY = brokenWall.startY;
        int wallEX = brokenWall.endX;
        int wallEY = brokenWall.endY;

        if ((playerSX == wallEX && playerSY < wallEY && playerEY > wallSY) || 
          (playerSY == wallEY && playerSX < wallEX && playerEX > wallSX) || 
          (playerEX == wallSX && playerSY < wallEY && playerEY > wallSY) || 
          (playerEY == wallSY && playerSX < wallEX && playerEX > wallSX))
        {
          levelState = LevelState.CAMERA;
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
    case PAUSE:
      pause.handleClick();
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
  PFont cyber = createFont("Fonts/renegado.ttf", 20);
  void drawStatusBar(String status)
  {
    fill(0);
    rect(0, 600, width, 620);
    fill(255);
    textSize(20);
    textAlign(LEFT);
    textFont(cyber);
    text(status, 100, 610);
  }
}

class Endpoint
{
  PImage closed;
  PImage open;
  int sX, sY, eX, eY;
  Level level;
  Endpoint(int sX, int sY, int eX, int eY, Level level, int rotate)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
    this.level = level;
    closed = loadImage("Art_Assets/In_Game/Levels/Elevator/ElevatorClose" + rotate + ".png");
    open = loadImage("Art_Assets/In_Game/Levels/Elevator/ElevatorOpen" + rotate + ".png");
  }

  void drawEndpoint()
  {
    if (level.player.hasData == level.dataNeeded)
    {
      fill(255, 0, 0);
      image(open, sX, sY);
      //rect(sX, sY, eX, eY);
    } else {
      image(closed, sX, sY);
    }
  }

  boolean levelCompleted(Player player)
  {
    return ((player.hasData == level.dataNeeded) && player.posX > sX && player.posX+30 < eX && player.posY > sY && player.posY+30 < eY);
  }
}

class Room
{
  int startX, startY, endX, endY;

  Room(int sX, int sY, int eX, int eY)
  {
    startX = sX;
    startY = sY;
    endX = eX;
    endY = eY;
  }
  void blackout()
  {
    fill(0, 190);
    rectMode(CORNERS);
    noStroke();
    rect(startX, startY, endX, endY);
    stroke(0);
  }
}

class PauseScreen
{
  Level parent;
  StateClass state;
  PImage scape;
  PFont cyber;
  ArrayList<Button> pauseButtons = new ArrayList<Button>();

  PauseScreen(Level _parent, StateClass state)
  {
    parent = _parent;
    this.state = state;
    scape = loadImage("Art_Assets/Frontend/febg.jpeg");
    scape.resize(1200, 620);
    cyber = createFont("Fonts/renegado.ttf", 130);
    pauseButtons.add(new Button("Continue Game", 750, 100, 755, 135, 30));
    pauseButtons.add(new Button("Controls", 750, 200, 810, 235, 30));
    pauseButtons.add(new Button("Settings", 750, 300, 822, 335, 30));
    pauseButtons.add(new Button("Return To Menu", 750, 400, 755, 435, 28));
    //note: add an option to save data?
    pauseButtons.add(new Button("Quit Game", 750, 500, 805, 535, 30));
  }
  void display()
  {
    noStroke();
    //draws background
    background(scape);

    //draws button banner
    rectMode(CORNER);
    fill(0);
    rect(750, 0, 300, 620);

    //draw game title
    fill(255);
    textSize(100);
    text("Code Noir", 30, 100);

    //draw buttons
    for (int i = 0; i < pauseButtons.size(); i++) {
      pauseButtons.get(i).drawButton();
      pauseButtons.get(i).checkHover();
    }
  }

  void handleClick()
  {
    //continue game is pressed
    if (mouseX > 750 && mouseX < 1050 && mouseY > 100 && mouseY < 150) {
      paused = false;
      parent.levelState = parent.prevState;
    }
    //controls is pressed
    if (mouseX > 750 && mouseX < 1050 && mouseY > 200 && mouseY < 250) {
      state.MenuState = menuState.CONTROLS;
      state.state = State.FRONTEND;
    }
    //settings is pressed
    if (mouseX > 750 && mouseX < 1050 && mouseY > 300 && mouseY < 350) {
      state.MenuState = menuState.SETTINGS;
      state.state = State.FRONTEND;
    }
    //return to menu is pressed
    if (mouseX > 750 && mouseX < 1050 && mouseY > 400 && mouseY < 450) {
      paused = false;
      state.MenuState = menuState.MAIN;
      state.state = State.FRONTEND;
    }
    //quit game is pressed
    if (mouseX > 750 && mouseX < 1050 && mouseY > 500 && mouseY < 550) {
      exit();
    }
  }
}