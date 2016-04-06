class BossGame extends Level
{
  ArrayList<MemoryLocation> gameGrid;
  String currentInput = "";
  String currMemoryAddress = "";
  PVector playerPos;
  StringList commands;
  boolean gameCompleted = false;
  boolean playerDestroyed = false;
  BossGameAI boss;
  PImage bg;
  int score = 0;
  StateClass state;
  PFont compFont = createFont("Fonts/Chava-Regular.ttf", 12);
  PImage playerHex;
  boolean showTut = true;
  PImage calloutImg = loadImage("Art_Assets/In_Game/BossFight/bosscallout.png");

  BossGame(StateClass state)
  {
    this.state = state;
    bg = loadImage("Art_Assets/In_Game/BossFight/backgroundfinallevl.png");
    bg.resize(1200, 620);
    gameGrid = new ArrayList<MemoryLocation>();
    int count = 0;
    String lines[] = loadStrings("Levels/Level_10/BossData.txt");
    for (int i = 0; i < 5; i ++)
    {
      if (i % 2 == 0)
      {
        for (int j = 0; j < 7; j ++)
        {
          String memAdress = "";
          boolean finished = false;
          char stateIdent = ' ';
          for (int k = 0; k < lines[count].length(); k++)
          {
            if (lines[count].charAt(k) == ' ')
            {
              finished = true;
            } else if (!finished) {
              memAdress += lines[count].charAt(k);
            } else {
              stateIdent = lines[count].charAt(k);
            }
          }
          if ( stateIdent == 'E') gameGrid.add(new MemoryLocation(j*100+420, i*90+30, memAdress, LocationState.EMPTY, new PVector(j, i), this));
          else if ( stateIdent == 'D') gameGrid.add(new MemoryLocation(j*100+420, i*90+30, memAdress, LocationState.DATA, new PVector(j, i), this));
          else if ( stateIdent == 'P')
          {
            gameGrid.add(new MemoryLocation(j*100+420, i*90+30, memAdress, LocationState.EMPTY, new PVector(j, i), this));
            currMemoryAddress = memAdress;
            playerPos = new PVector(j, i);
          }
          count++;
        }
      } else
      {
        for (int j = 0; j < 7; j ++)
        { 
          String memAdress = "";
          boolean finished = false;
          char stateIdent = ' ';
          for (int k = 0; k < lines[count].length(); k++)
          {
            if (lines[count].charAt(k) == ' ')
            {
              finished = true;
            } else if (!finished) {
              memAdress += lines[count].charAt(k);
            } else {
              stateIdent = lines[count].charAt(k);
            }
          }
          if ( stateIdent == 'E') gameGrid.add(new MemoryLocation(j*100+470, i*90+30, memAdress, LocationState.EMPTY, new PVector(j, i), this));
          else if ( stateIdent == 'D') gameGrid.add(new MemoryLocation(j*100+470, i*90+30, memAdress, LocationState.DATA, new PVector(j, i), this));
          else if ( stateIdent == 'P')
          {
            gameGrid.add(new MemoryLocation(j*100+470, i*90+30, memAdress, LocationState.EMPTY, new PVector(j, i), this));
            currMemoryAddress = memAdress;
            playerPos = new PVector(j, i);
          }
          count++;
        }
      }
    }
    boss = new BossGameAI(this);
    commands = new StringList();
    textSize(10);
    playerHex = loadImage("Art_Assets/In_Game/BossFight/hexagon3.png");
  }

  boolean checkEnd()
  {
    for (MemoryLocation loc : gameGrid) { 
      if (loc.state == LocationState.DATA) return false;
    }
    return true;
  }

  void drawLevel()
  {
    textFont(compFont);
    drawGame();
    if (showTut)
    {
      fill(0, 255, 255);
      image(calloutImg, (width/2)-300, (height/2)-150);
      text("Brain Jack connection successful", 320, 220);
      text("Available Commands: ", 320, 260);
      text("goto MEMADDRESS       Goes an adjacent memory adress", 320, 280);
      text("upload                        Uploads the memory you are currently accessing.", 320, 300);
      text("Memory Colours:", 320, 340);
      fill(255, 255, 0);
      text("Uploadable Data", 320, 360);
      fill(0, 255, 0);
      text("Uploaded Memory", 450, 360);
      fill(0, 255, 255);
      text("Current Memory", 580, 360); 
      fill(255, 0, 0);
      text("Memory being deleted", 700, 360); 
      fill(0, 255, 255);
      text("Upload as much data as possible. Do not get deleted.", 320, 400);
      text("Press any key to begin brain computer interfacing.", 320, 420);
    } else if (!gameCompleted && !playerDestroyed)
    {
      boss.run();
    } else if (playerDestroyed)
    {
      image(calloutImg, (width/2)-300, (height/2)-150);
      fill(0, 255, 255);
      textAlign(CENTER);
      text("SYSTEM ERR: Bad Mem Adress.", width/2, (height/2)-20);
      text("Connection terminated with code -1.", width/2, (height/2));
      text("Press and key to release.", width/2, (height/2)+20);
      textAlign(LEFT);
    } else {
      image(calloutImg, (width/2)-300, (height/2)-150);
      textAlign(CENTER);
      text("Data points uploaded: " + score + ".", width/2, (height/2)-20);
      text("Press any key to exit connection.", width/2, (height/2));
      textAlign(LEFT);
    }
  }

  void drawGame()
  {

    background(bg);
    fill(0, 255, 255);
    for (MemoryLocation loc : gameGrid) loc.draw();
    textAlign(LEFT);
    text(currentInput, 100, 590);

    text("Output log: ", 50, 320);
    if (commands.size() > 10)
    {
      commands.remove(0);
    }
    for (int i = 0; i < commands.size(); i++)
    {
      text(commands.get(i), 70, 20*i+340);
    }
    fill(0, 255, 255);
    text("Connection Status: Jacked In", 50, 60);
    text("Available Commands: ", 50, 140);
    text("goto MEMADDRESS ", 50, 160);
    text("upload", 50, 180);
    text("Memory Colours:", 50, 220);
    fill(255, 255, 0);
    text("Uploadable data", 50, 240);
    fill(0, 255, 0);
    text("Uploaded Memory", 50, 260);
    fill(0, 255, 255);
    text("Current Memory", 50, 280);
    fill(255, 0, 0);
    text("Memory being deleted", 50, 300);
    fill(0, 255, 255);
    text("CMD: ", 50, 590);
    boss.draw();
    gameCompleted = checkEnd();
    if (playerPos.y%2 ==0) image(playerHex, playerPos.x*100+424, playerPos.y*90+34);
    else image(playerHex, playerPos.x*100+474, playerPos.y*90+34);
  }

  void executeCommand(String command)
  {
    if (command.length() < 5) return;
    if (command.charAt(0) == 'g' && command.charAt(1) == 'o' && command.charAt(2) == 't' && command.charAt(3) == 'o' && command.charAt(4) == ' ')
    {
      String memLoc = "";
      for (int i = 5; i< command.length(); i++)
      {
        memLoc += command.charAt(i);
      }
      for (MemoryLocation loc : gameGrid)
      {
        if (loc.address.equals(memLoc))
        {
          boolean canMove = false;
          for (MemoryLocation loc2 : gameGrid)
          {
            if (loc2.address.equals(currMemoryAddress))
            {
              float pX = playerPos.x;
              float pY = playerPos.y;
              float lX = loc.gridRef.x;
              float lY = loc.gridRef.y;
              if (((pY%2 == 0 && ((lX == pX-1 && lY == pY-1) || (lX == pX && lY == pY-1) || (lX == pX+1 && lY == pY) || 
                (lX == pX && lY == pY+1) || (lX == pX-1 && lY == pY+1) || (lX == pX-1 && lY == pY)))
                || (pY%2 == 1 && ((lX == pX && lY == pY-1)|| (lX == pX+1 && lY == pY-1) || (lX == pX+1 && lY == pY) || 
                (lX == pX+1 && lY == pY+1) || (lX == pX && lY == pY+1) || (lX == pX-1 && lY == pY)))) && loc.state != LocationState.DESTROYED)
              {
                loc2.reset();
                canMove = true;
              }
            }
          } 
          if (canMove)
          {
            playerPos = loc.gridRef;
            currMemoryAddress = memLoc;
            commands.append("goto " + memLoc + " successful");
            return;
          }
        }
      }
      commands.append("goto " + memLoc + " failed");
    } else if (command.charAt(0) == 'u' && command.charAt(1) == 'p' && command.charAt(2) == 'l' && command.charAt(3) == 'o' && command.charAt(4) == 'a' && command.charAt(5) == 'd')
    {
      for (MemoryLocation loc : gameGrid)
      {
        if (loc.address.equals(currMemoryAddress) && loc.state == LocationState.DATA)
        {
          loc.upload();
          score++;
          commands.append("upload successful");
          return;
        }
      }
      commands.append("upload failed");
    } else {
      commands.append("unrecognised command");
    }
  }

  void handleKeyOn()
  {
    if (showTut)
    {
      showTut = false; 
      return;
    }
    if (gameCompleted)
    {
      if (score > 4)
      {
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/finalcs.png", "Levels/Level_10/Level 10 PostText3.txt");
        state.state = State.CUTSCREENS;
        level = new GameFinished("Art_Assets/In_Game/Cutscreens/gameend1.png", state);
        currentLevel++;
      } else
      {
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/finalcs.png", "Levels/Level_10/Level 10 PostText2.txt");
        state.state = State.CUTSCREENS;
        level = new GameFinished("Art_Assets/In_Game/Cutscreens/ending2.png", state);
        currentLevel++;
      }
      return;
    }
    if (playerDestroyed)
    {
      if (score < 4)
      {
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/finalcs.png", "Levels/Level_10/Level 10 PostText1.txt");
        state.state = State.CUTSCREENS;
        level = new GameFinished("Art_Assets/In_Game/Cutscreens/ending3.png", state);
        currentLevel++;
        return;
      } else
      {
        cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/finalcs.png", "Levels/Level_10/Level 10 PostText2.txt");
        state.state = State.CUTSCREENS;
        level = new GameFinished("Art_Assets/In_Game/Cutscreens/ending2.png", state);
        currentLevel++;
        return;
      }

      if (key == ENTER || key == RETURN)
      {
        executeCommand(currentInput);
        currentInput = "";
      } else if (key == BACKSPACE)
      {
        if (currentInput.length() > 0) currentInput = currentInput.substring(0, currentInput.length()-1);
      } else if (key != CODED)
      {
        currentInput +=(char)key;
      }
    }
    void handleKeyOff() {
    }

    void handleMousePressed() {
    }
    void handleMouseReleased() {
    }
    void handleMouseDragged() {
    }
  }

  class MemoryLocation
  {
    int x;
    int y;
    String address;
    PImage dispImage;
    LocationState state;
    PVector gridRef;
    BossGame game;

    MemoryLocation(int x, int y, String address, LocationState state, PVector gridRef, BossGame game)
    {
      this.x = x;
      this.y = y;
      dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon.png");
      this.address = address;
      this.state = state;
      this.gridRef = gridRef;
      this.game = game;

      switch(state)
      {
      case EMPTY:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon.png");
          break;
        }
      case DATA:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon5.png");
          break;
        }
      case UPLOADED:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon6.png");
          break;
        }
      }
    }

    void draw()
    {
      if (state != LocationState.DESTROYED)
      {
        image(dispImage, x, y);
        textAlign(CENTER);
        text(address, x+59, y+59);
      }
    }

    void upload()
    {
      state = LocationState.UPLOADED;
      dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon6.png");
    }

    void destroy()
    {
      if (state == LocationState.UPLOADED) return;
      state = LocationState.DESTROYED;
    }

    void reset()
    {
      switch(state)
      {
      case EMPTY:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon.png");
          break;
        }
      case DATA:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon5.png");
          break;
        }
      case UPLOADED:
        {
          dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon6.png");
          break;
        }
      }
    }
  }

  enum LocationState
  {
    EMPTY, 
      DATA, 
      UPLOADED, 
      DESTROYED
  }

    class BossGameAI
  {
    boolean targetChosen = false;
    String command;
    String fromCommand = "destroy ";
    BossGame game;
    int targetLocation;
    int timer;
    int destroyed = 0;
    ArrayList<PImage> targetImgs = new ArrayList<PImage>();

    BossGameAI(BossGame game)
    {
      this.game = game;
      timer= millis();
      findTarget();
      command = "";
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon51.png"));
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon52.png"));
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon53.png"));
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon54.png"));
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon55.png"));
      targetImgs.add(loadImage("Art_Assets/In_Game/BossFight/hexagon56.png"));
    }

    void run()
    {
      if (!targetChosen)
      {
        findTarget();
      } else {
        if (millis()-timer > 1000 - (50*destroyed))
        {
          timer = millis();
          MemoryLocation target = game.gameGrid.get(targetLocation);

          if (command.length() < target.address.length() + fromCommand.length())
          {
            if (command.length() < fromCommand.length())
            {
              command += fromCommand.charAt(command.length());
            } else {
              command += target.address.charAt(command.length()-fromCommand.length());
            }
          } else {
            if (game.gameGrid.get(targetLocation).gridRef.x == game.playerPos.x && game.gameGrid.get(targetLocation).gridRef.y == game.playerPos.y) game.playerDestroyed = true;
            target.destroy();
            destroyed++;
            targetChosen = false;
            command = "";
            findTarget();
          }
        }
      }
    }

    void draw()
    {
      fill(0, 255, 255);
      text("Incoming remote command: ", 50, 80);
      fill(255, 0, 0);
      text(command, 50, 100);
      for (int i = 0; i < (command.length()/2); i++)
      {
        if ( i >= targetImgs.size()) return;
        image(targetImgs.get(i), game.gameGrid.get(targetLocation).x, game.gameGrid.get(targetLocation).y);
      }
    }

    void findTarget()
    {
      for (int i = 0; i < game.gameGrid.size(); i++)
      {
        MemoryLocation location = game.gameGrid.get(i);
        if (location.gridRef.x == game.playerPos.x && location.gridRef.y == game.playerPos.y)
        {
          targetLocation = i;
          targetChosen = true;
          return;
        }
      }
    }
  }