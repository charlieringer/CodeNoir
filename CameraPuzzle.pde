class CameraPuzzle
{
  Camera camera;
  ArrayList<CPWall> walls = new ArrayList<CPWall>();
  boolean gameOver;
  boolean gameWon = false;

  CameraPuzzle()
  {
    walls.add(new CPWall(0, 0, 5, height));
    walls.add(new CPWall(0, 0, width, 5));
    walls.add(new CPWall(0, height-5, width, height));
    walls.add(new CPWall(width-5, 0, width, height));

    int gap = height/2-25;
    camera = new Camera(10, gap+25, 'r', 2);

    for (int i = 40; i < width-40; i+=20)
    {
      int move = (int)random(0, 3);
      if (move == 0 && gap < height-60) gap+=15;
      else if ( move == 1 && gap > 60 ) gap-=15;

      walls.add(new CPWall(i, 0, i+20, gap));
      walls.add(new CPWall(i, gap+50, i+20, height));
    }
  }

  void reset() {
    int gap = height/2-25;
    camera = new Camera(10, gap+25, 'r', 2);
    gameOver = false;
  }

  void runGame() {
    background(255);
    if (!gameOver) {
      for (int i = 0; i < walls.size(); i++)
      {
        walls.get(i).drawWall();
      }
      camera.moveAndDraw();
      gameOver = camera.checkEnd(walls);
      gameWon = camera.checkWin();
    } else if (gameWon)
    {
      background(255);
      String modelString = "You won";
      textAlign (CENTER);
      fill(0);
      text(modelString, 200, 200, 40);
    } else {
      background(255, 0, 0);
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

  Camera(int x, int y, char dir, int speed)
  {
    head = new CameraPart(x, y);
    this.dir = dir;
    this.speed = speed;
  }

  void moveAndDraw()
  {
    moveCamera();
    drawCamera();
  }

  void drawCamera()
  {
    fill(0);
    CameraPart current = head;
    
    while (current != null)
    {
     ellipse(current.x, current.y, 10, 10); 
     current = current.next;
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
    noStroke();
    fill(128);
    rectMode(CORNERS);
    rect(startX, startY, endX, endY);
  }
}