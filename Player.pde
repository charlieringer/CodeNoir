class Player
{
  int posX;
  int posY;
  ArrayList<Wall> walls;
  ArrayList<LargeObject> desks;
  ArrayList<Door> doors;
  ArrayList<Guard> guards;

  boolean goingUp = false;
  boolean goingDown = false;
  boolean goingLeft = false;
  boolean goingRight = false;
  boolean hasData = false;

  Player(ArrayList<Wall> walls, ArrayList<LargeObject> desks, ArrayList<Door> doors, ArrayList<Guard> guards)
  {
    this.walls = walls;
    this.desks = desks;
    this.guards = guards;
    this.doors = doors;
    posX = 120;
    posY = 520;
  }

  void updateAndDraw()
  {
    updatePosition(walls, desks);
    drawPlayer();
  }
  void drawPlayer()
  {
    fill(0, 0, 255);
    rectMode(CORNER);
    rect(posX, posY, 30, 30);
  }

  void updatePosition(ArrayList<Wall> wallObjs, ArrayList<LargeObject> desks)
  {
    assert(wallObjs != null);
    boolean canUp = true;
    boolean canDown = true;
    boolean canLeft = true;
    boolean canRight = true;

    for (int i = 0; i < wallObjs.size (); i++)
    {
      int wallSX = wallObjs.get(i).startX;
      int wallSY = wallObjs.get(i).startY;
      int wallEX = wallObjs.get(i).endX;
      int wallEY = wallObjs.get(i).endY;

      if (posX < wallEX && posX+30 > wallSX && posY-5 < wallEY && posY +25  > wallSY) canUp = false;
      if (posX < wallEX && posX+30 > wallSX && posY+5 < wallEY && posY +35  > wallSY) canDown = false;
      if (posX-5 < wallEX && posX+25 > wallSX && posY < wallEY && posY +30  > wallSY) canLeft = false;
      if (posX+5 < wallEX && posX+33 > wallSX && posY < wallEY && posY +30  > wallSY) canRight = false;
    }

    for (int i = 0; i < desks.size (); i++)
    {
      int deskSX = desks.get(i).startX;
      int deskSY = desks.get(i).startY;
      int deskEX = desks.get(i).endX;
      int deskEY = desks.get(i).endY;

      if (posX < deskEX && posX+30 > deskSX && posY-5 < deskEY && posY +25  > deskSY) canUp = false;
      if (posX < deskEX && posX+30 > deskSX && posY+5 < deskEY && posY +35  > deskSY) canDown = false;
      if (posX-5 < deskEX && posX+25 > deskSX && posY < deskEY && posY +30  > deskSY) canLeft = false;
      if (posX+5 < deskEX && posX+33 > deskSX && posY < deskEY && posY +30  > deskSY) canRight = false;
    }

    for (int i = 0; i < doors.size (); i++)
    {
      int doorSX = doors.get(i).startX;
      int doorSY = doors.get(i).startY;
      int doorEX = doors.get(i).endX;
      int doorEY = doors.get(i).endY;

      if (posX < doorEX && posX+30 > doorSX && posY-5 < doorEY && posY +25  > doorSY) canUp = false;
      if (posX < doorEX && posX+30 > doorSX && posY+5 < doorEY && posY +35  > doorSY) canDown = false;
      if (posX-5 < doorEX && posX+25 > doorSX && posY < doorEY && posY +30  > doorSY) canLeft = false;
      if (posX+5 < doorEX && posX+33 > doorSX && posY < doorEY && posY +30  > doorSY) canRight = false;
    }

    for (int i = 0; i < guards.size(); i++)
    {
      if (!guards.get(i).alive)
      {
        continue;
      }
      int guardSX = guards.get(i).posX;
      int guardSY = guards.get(i).posY;
      int guardEX = guardSX+30;
      int guardEY = guardSY+30;

      if (posX < guardEX && posX+30 > guardSX && posY-5 < guardEY && posY+25  > guardSY) canUp = false;
      if (posX < guardEX && posX+30 > guardSX && posY+5 < guardEY && posY+35  > guardSY) canDown = false;
      if (posX-2 < guardEX && posX-2 > guardSX && posY < guardEY && posY +30  > guardSY) canLeft = false;
      if (posX+28 < guardEX && posX+28 > guardSX && posY < guardEY && posY +30  > guardSY) canRight = false;
    }


    if (goingUp && canUp) posY-=5;
    if (goingDown&& canDown) posY+=5;
    if (goingLeft && canLeft) posX-=5;
    if (goingRight && canRight) posX+=5;
  }

  void handleKey(boolean state)
  {
    if (key == CODED)
    {
      if (keyCode == UP)
      {
        goingUp = state;
      } else if (keyCode == DOWN)
      {
        goingDown = state;
      } else if (keyCode == LEFT)
      {
        goingLeft = state;
      } else if (keyCode == RIGHT)
      {
        goingRight = state;
      }
    } else if (key == ' ')
    {
      interact();
    }
  }
  void checkVision(ArrayList<Room> visionRooms)
  {
    for (int i = 0; i < visionRooms.size(); i++)
    {
      int roomSX = visionRooms.get(i).startX;
      int roomSY = visionRooms.get(i).startY;
      int roomEX = visionRooms.get(i).endX;
      int roomEY = visionRooms.get(i).endY;
      if (!(posX+15 > roomSX && posX+15 < roomEX && posY+15 > roomSY && posY+15 < roomEY))
      {
        visionRooms.get(i).blackout();
      }
    }
  }

  void interact()
  {
    for (int i = 0; i < guards.size(); i++)
    {
      Guard thisGuard = guards.get(i);
      if (!thisGuard.alive)
        continue; 
      if (nextTo(thisGuard))
      {
        thisGuard.alive = false;
        return;
      }
    }
  }

  boolean nextTo(Guard guard)
  {
    //From right
    if ((posX-2) <= (guard.posX+30) && posX-(guard.posX+30) >= 0 && posX-(guard.posX+30) <=2 && posY < guard.posY+30 && posY+30 > guard.posY) return true;
    //From left 
    else if ((posX+32) >= guard.posX && (posX+32)-guard.posX >= 0 && (posX+34)-guard.posX <=7 && posY < (guard.posY+30) && (posY+30) > guard.posY) return true;

    //From bottom
    else if ((posY-2) <= (guard.posY+30) && posY-(guard.posY+30) >= 0 && posY-(guard.posY+30) <= 2 && posX < (guard.posX+30) && (posX+30) > guard.posX) return true;
    //from top
    else if (posY+32 >= guard.posY && (posY+32)-guard.posY >= 0 && (posY+32)-guard.posY <= 2 && posX < (guard.posX+30) && (posX+30) > guard.posX) return true;
    return false;
  }
}