class BrokenWall extends Wall
{
  CameraPuzzle puzzle;
  Level level;

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
      //Draw cutscreen thing
      background(0);
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
  PImage border = loadImage("Art_Assets/In_Game/Camera/cameraPuzzBorder.png");

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
      if (move == 0 && gap < height-200) gap+=20;
      else if ( move == 1 && gap > 200 ) gap-=20;

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
    stroke(0);
    background(40);
    camera.drawCamera();
    for (int i = 0; i < walls.size(); i++)
    {
      walls.get(i).drawWall();
    }


    fill(0);
    rect(0, 0, width, 180);
    rect(0, height-180, width, height);
    image(border, 0, 0);
    textAlign (CENTER);
    fill(255);
    text("Wall scan complete", width/2, 120, 40);
    text("Feed camera through wall. Use U/D/L/R arrows to condtrol", width/2, 160, 40);

    if (!gameOver) {
      camera.moveCamera();
      gameOver = camera.checkEnd(walls);
      gameWon = camera.checkWin();
    } else {
      String modelString = "Game Over, Press 'r' to restart";
      textAlign (CENTER);
      fill(0);
      text(modelString, 200, 200, 40);
    }
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
    return (checkCollSelf()||checkCollWalls(walls));
  }

  boolean checkWin()
  {
    return (head.x > width-20);
  }

  boolean checkCollSelf()
  {
    CameraPart current = head.next;

    while (current!=null)
    {
      if (head.x==current.x && head.y == current.y) return true;
      current = current.next;
    }
    return false;
  }

  boolean checkCollWalls(ArrayList<CPWall> walls)
  {
    int x = head.x;
    int y = head.y;
    for (int i = 0; i < walls.size(); i++)
    {
      CPWall wall = walls.get(i);
      if (x < wall.endX && x > wall.startX && y < wall.endY && y > wall.startY) 
      {
        return true;
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