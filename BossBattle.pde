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
  int score = 0;

  BossGame()
  {
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
          if ( stateIdent == 'E') gameGrid.add(new MemoryLocation(j*100+400, i*90+50, memAdress, LocationState.EMPTY, new PVector(j, i), this));
          else if ( stateIdent == 'D') gameGrid.add(new MemoryLocation(j*100+400, i*90+50, memAdress, LocationState.DATA, new PVector(j, i), this));
          else if ( stateIdent == 'P')
          {
            gameGrid.add(new MemoryLocation(j*100+400, i*90+50, memAdress, LocationState.PLAYER, new PVector(j, i), this));
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
          if ( stateIdent == 'E') gameGrid.add(new MemoryLocation(j*100+450, i*90+50, memAdress, LocationState.EMPTY, new PVector(j, i), this));
          else if ( stateIdent == 'D') gameGrid.add(new MemoryLocation(j*100+450, i*90+50, memAdress, LocationState.DATA, new PVector(j, i), this));
          else if ( stateIdent == 'P')
          {
            gameGrid.add(new MemoryLocation(j*100+450, i*90+50, memAdress, LocationState.PLAYER, new PVector(j, i), this));
            currMemoryAddress = memAdress;
            playerPos = new PVector(j, i);
          }
          count++;
        }
      }
    }
    boss = new BossGameAI(gameGrid);
    commands = new StringList();
    textSize(10);
  }

  boolean checkEnd()
  {
    int count = 0;
    for (MemoryLocation loc : gameGrid) { 
      if (loc.state == LocationState.DATA || loc.prevState == LocationState.DATA) return false;
      if (loc.state == LocationState.UPLOADED) count++;
    }
    score = count;
    return true;
  }

  void drawLevel()
  {
    if (!gameCompleted && !playerDestroyed)
    {
      background(255);
      for (MemoryLocation loc : gameGrid) loc.draw();
      text(currentInput, 100, 600);
      text("Output log: ", 50, 220);
      if (commands.size() > 17)
      {
        commands.remove(0);
      }
      for (int i = 0; i < commands.size(); i++)
      {
        text(commands.get(i), 50, 20*i+240);
      }
      text("Available Commands: ", 50, 100);
      text("goto MEMADDRESS ", 50, 120);
      text("Goes an adjacent memory adress", 70, 140);
      text("upload", 50,160);
      text("Uploads the memory you are currently accessing.", 70, 180);
      boss.run();
      boss.draw();
      gameCompleted = checkEnd();
    } else if (playerDestroyed)
    {
      background(0);
      fill(255);
      text("SYSTEM ERR: Bad Mem Adress. Program terminated with code -1. Please reboot.", 100, 100);
    } else {
      background(255);
      text("Data points uploaded: " + score, 100, 100);
    }
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
            loc.changeToPlayer();
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
        if (loc.address.equals(currMemoryAddress) && loc.prevState == LocationState.DATA)
        {
          loc.upload();
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
  void handleKeyOff(){}
  
  void handleMousePressed(){}
  void handleMouseReleased(){}
  void handleMouseDragged(){}
}

class MemoryLocation
{
  int x;
  int y;
  String address;
  PImage dispImage;
  LocationState state;
  LocationState prevState = LocationState.EMPTY;
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
    case DESTROYED:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon2.png");
        break;
      }
    case PLAYER:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon3.png");
        break;
      }
    case BOSS:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon4.png");
      }
    }
  }

  void draw()
  {
    image(dispImage, x, y);
    fill(0);
    text(address, x+5, y+65);
  }

  void changeToPlayer()
  {
    prevState = state;
    state = LocationState.PLAYER;
    dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon3.png");
  }

  void upload()
  {
    if (prevState == LocationState.DATA && state == LocationState.PLAYER)
    {
      state = LocationState.UPLOADED;
      prevState = LocationState.UPLOADED;
      dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon6.png");
    }
  }

  void destroy()
  {
    if (state == LocationState.PLAYER) game.playerDestroyed = true;
      state = LocationState.DESTROYED;
    prevState = LocationState.DESTROYED;
    dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon2.png");
  }

  void reset()
  {
    state = prevState;

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
    case DESTROYED:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon2.png");
        break;
      }
    case PLAYER:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon3.png");
        break;
      }
    case BOSS:
      {
        dispImage = loadImage("Art_Assets/In_Game/BossFight/hexagon4.png");
      }
    }
  }
}

enum LocationState
{
  EMPTY, 
    DATA, 
    UPLOADED, 
    DESTROYED, 
    PLAYER, 
    BOSS
}

class BossGameAI
{
  boolean targetChosen = false;
  String command;
  String fromCommand = "destroy ";
  ArrayList<MemoryLocation> game;
  int targetLocation;
  int timer;

  BossGameAI(ArrayList<MemoryLocation> game)
  {
    this.game = game;
    timer= millis();
    findTarget();
    command = "";
  }

  void run()
  {
    if (!targetChosen)
    {
      findTarget();
    } else {
      if (millis()-timer >500)
      {
        timer = millis();
        MemoryLocation target = game.get(targetLocation);

        if (command.length() < target.address.length() + fromCommand.length())
        {
          if (command.length() < fromCommand.length())
          {
            command += fromCommand.charAt(command.length());
          } else {
            command += target.address.charAt(command.length()-fromCommand.length());
          }
        } else {
          target.destroy();
          targetChosen = false;
          command = "";
          findTarget();
        }
      }
    }
  }

  void draw()
  {
    text("Incoming remote command: ", 50, 50);
    text(command, 50, 70);
  }

  void findTarget()
  {
    while (!targetChosen)
    {
      int potentialTarget = (int)random(0, game.size());
      if (game.get(potentialTarget).state != LocationState.DESTROYED && game.get(potentialTarget).state != LocationState.UPLOADED) 
      {
        targetLocation = potentialTarget;
        targetChosen = true;
      }
    }
  }
}