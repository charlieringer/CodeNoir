class BrokenWall extends Wall
{
  CameraPuzzle puzzle;
  Level level;
  CutScreens cutScreen;
  Boolean dataDone = false;

  BrokenWall(int newSX, int newSY, int newEX, int newEY, Level parentLevel)
  {
    super(newSX, newSY, newEX, newEY);
    puzzle = new CameraPuzzle();
    level = parentLevel;
  }

  void drawOnOwn()
  {
    if (!puzzle.gameWon)
    {
      puzzle.runGame();
    } else
    {
      if (!dataDone)
      {
        level.player.hasData+=1;
        dataDone = true;
      }
      //Draw cutscreen once end is reached
      cutScreens = new CutScreens(state, "Art_Assets/In_Game/Cutscreens/cutscreen.png", "Levels/Level_7/cutscreen.txt");
      state.state = State.CUTSCREENS;
    }
  }

  void handleKey()
  {
    if (key == TAB)
    {
      level.levelState = LevelState.LEVEL;
    } else if (!puzzle.gameWon)
    {
      puzzle.handleKey();
    }
  }
}

class CameraPuzzle
{
  Camera camera;
  ArrayList<CPWall> walls = new ArrayList<CPWall>();
  boolean gameOver;
  boolean gameWon = false;
  //top of tablet
  PImage tablet1 = loadImage("Art_Assets/In_Game/Camera/tablet1.png");
  //middle of tablet
  PImage tablet2 = loadImage("Art_Assets/In_Game/Camera/tablet2.png");
  //bottom of tablet
  PImage tablet3 = loadImage("Art_Assets/In_Game/Camera/tablet3.png");
  PImage tablet4 = loadImage("Art_Assets/In_Game/Camera/tablet4.png");
  PImage lose = loadImage("Art_Assets/In_Game/Camera/cameraGameOver.png");

  CameraPuzzle()
  {

    int gap = height/2-30;
    camera = new Camera(0, gap+20, 'r', 2);
    walls.add(new CPWall(40, 0, 80, gap-20));
    walls.add(new CPWall(80, 0, 120, gap));
    walls.add(new CPWall(40, gap+60, 80, height));
    walls.add(new CPWall(80, gap+40, 120, height));

    for (int i = 120; i < width-40; i+=40)
    {
      int move = (int)random(0, 3);
      if (move == 0 && gap < height-220) gap+=20;
      else if ( move == 1 && gap > 220 ) gap-=20;

      walls.add(new CPWall(i, 0, i+40, gap));
      walls.add(new CPWall(i, gap+40, i+40, height));
    }
  }

  void reset() {
    int gap = height/2-25;
    camera = new Camera(10, gap+20, 'r', 2);
    gameOver = false;
  }

  void runGame() {
    //image for middle section of tablet, behind camera puzzle game
    image(tablet2, 0, 190);
    //stroke(0);
    noStroke();
    camera.drawCamera();

    for (int i = 0; i < walls.size(); i++)
    {
      walls.get(i).drawWall();
    }
    //top section of tablet, in front of camera puzzle to block some walls
    image(tablet1, 0, 0);
    //bottom section of tablet, in front of camera puzzle to block some walls
    image(tablet3, 0, 430);
    //image for edges section of tablet
    image(tablet4, 0, 190);

    textAlign (CENTER);
    fill(255);
    text("Wall scan complete", width/2, 130, 40);
    text("Feed camera through wall. Use U/D/L/R arrows to control", width/2, 170, 40);

    if (!gameOver) {
      camera.moveCamera();
      gameOver = camera.checkEnd(walls);
      gameWon = camera.checkWin();
    } else {
      image(lose, 300, 200);
    }
    textAlign(LEFT);
  }

  void handleKey()
  {

    if (!gameOver)
    {
      camera.handleInput();
    } else if (keyCode == 'R') {
      reset();
    }
  }
}

class Camera
{
  CameraPart head;
  char dir;
  int speed;
  PImage cameraU = loadImage("Art_Assets/In_Game/Camera/cameraU.png");
  PImage cameraD = loadImage("Art_Assets/In_Game/Camera/cameraD.png");
  PImage cameraL = loadImage("Art_Assets/In_Game/Camera/cameraL.png");
  PImage cameraR = loadImage("Art_Assets/In_Game/Camera/cameraR.png");

  Camera(int x, int y, char dir, int speed)
  {
    head = new CameraPart(x, y);
    this.dir = dir;
    this.speed = speed;
  }

  void drawCamera()
  {

    CameraPart current = head;

    current = current.next;

    fill(0);
    while (current != null)
    {
      ellipse(current.x, current.y, 5, 5); 
      current = current.next;
    }
    noStroke();
    fill(128); 
    if (dir == 'u')
    {
      //rect(head.x-5, head.y+5, head.x+5, head.y-10);
      image(cameraU, head.x-5, head.y-5);
    } else if (dir == 'd')
    {
      //rect(head.x-5, head.y-2, head.x+5, head.y+10);
      image(cameraD, head.x-5, head.y-15);
    } else if (dir == 'l')
    {
      //rect(head.x+5, head.y-5, head.x-10, head.y+5);
      image(cameraL, head.x-5, head.y-5);
    } else if (dir == 'r')
    {
      //rect(head.x-5, head.y-5, head.x+10, head.y+5);
      image(cameraR, head.x-15, head.y-5);
    }
  }

  void moveCamera()
  {
    if (dir == 'u') head = new CameraPart(head.x, head.y-speed, head);
    else if (dir == 'd') head = new CameraPart(head.x, head.y+speed, head);
    else if (dir == 'l') head = new CameraPart(head.x-speed, head.y, head);
    else if (dir == 'r') head = new CameraPart(head.x+speed, head.y, head);
  }

  void handleInput()
  {
    if (key == CODED)
    {
      if (keyCode == UP && (dir != 'u' || dir != 'd') ) dir = 'u';
      else if (keyCode == DOWN && (dir != 'u' || dir != 'd') ) dir = 'd';
      else if (keyCode == LEFT && (dir != 'l' || dir != 'r') ) dir = 'l';
      else if (keyCode == RIGHT && (dir != 'l' || dir != 'r') ) dir = 'r';
    }
  }

  boolean checkEnd(ArrayList<CPWall> walls)
  {
    return (checkCollWalls(walls));
  }

  boolean checkWin()
  {
    return (head.x > width-20);
  }

  boolean checkCollWalls(ArrayList<CPWall> walls)
  {
    int x = head.x;
    int y = head.y;
    for (int i = 0; i < walls.size(); i++)
    {
      CPWall wall = walls.get(i);
      if (dir == 'u')
      {
        if (x-5 < wall.endX && x+5 > wall.startX && y-5 < wall.endY && y-5 > wall.startY) 
        {
          return true;
        }
      } else if (dir =='d')
      {
        if (x-5 < wall.endX && x+5 > wall.startX && y+5 < wall.endY && y+5 > wall.startY) 
        {
          return true;
        }
      } else if (dir == 'l')
      {
        if (x-5 < wall.endX && x-5 > wall.startX && y-5 < wall.endY && y+5 > wall.startY) 
        {
          return true;
        }
      } else if (dir == 'r')
      {
        if (x+5 < wall.endX && x+5 > wall.startX && y-5 < wall.endY && y+5 > wall.startY) 
        {
          return true;
        }
      }
    }
    return false;
  }
}

class CameraPart
{
  int x, y;
  CameraPart next;

  CameraPart(int x, int y)
  {
    this.x = x;
    this.y = y;
    next = null;
  }

  CameraPart(int x, int y, CameraPart  next)
  {
    this.x = x;
    this.y = y;
    this.next = next;
  }
}

class CPWall
{
  PImage texture = loadImage("Art_Assets/In_Game/Camera/brick.png");
  int startX, startY, endX, endY;

  CPWall(int startX, int startY, int endX, int endY)
  {
    this.startX = startX;
    this.startY = startY;
    this.endX= endX;
    this.endY = endY;
  }

  void drawWall()
  {
    for (int i = startY; i < endY; i+=20)
    {
      image(texture, startX, i);
    }
  }
}