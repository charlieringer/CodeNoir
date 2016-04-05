class Player
{
  int posX;
  int posY;
  ArrayList<Wall> walls;
  ArrayList<LargeObject> desks;
  ArrayList<Door> doors;
  ArrayList<Guard> guards;
  ArrayList<PImage> sprites;
  PImage interactSprite;
  int interactFrameCount;

  boolean goingUp = false;
  boolean goingDown = false;
  boolean goingLeft = false;
  boolean goingRight = false;
  boolean interacting = false;
  char prevRot = 'u';
  int hasData = 0;
  int spriteNumb = 0;
  int storedFrame = 0;
  float speed = 4.0;

  Player(ArrayList<Wall> walls, ArrayList<LargeObject> desks, ArrayList<Door> doors, ArrayList<Guard> guards, int x, int y)
  {
    this.walls = walls;
    this.desks = desks;
    this.guards = guards;
    this.doors = doors;
    posX = x;
    posY = y;
    sprites = new ArrayList<PImage>();
    sprites.add(loadImage("Art_Assets/In_Game/Player/protagstill.png"));
    sprites.add(loadImage("Art_Assets/In_Game/Player/protagforward.png"));
    sprites.add(loadImage("Art_Assets/In_Game/Player/protagforward2.png"));
    interactSprite = loadImage("Art_Assets/In_Game/Player/protagattack.png");
  }

  void updateAndDraw()
  {
    updatePosition(walls, desks);
    drawPlayer();
  }
  void drawPlayer()
  {
    if (goingUp||goingDown||goingLeft||goingRight)
    {
      if (goingUp)
      {
        prevRot = 'u';
        pushMatrix();
        translate(posX, posY);
        rotate(radians(0));
        if (interacting)image(interactSprite, 0, 0);
        else image(sprites.get(spriteNumb), 0, 0);
        popMatrix();
      } else if (goingDown)
      {
        prevRot = 'd';
        pushMatrix();
        translate(posX, posY);
        rotate(radians(180));
        if (interacting)image(interactSprite, -30, -30);
        else image(sprites.get(spriteNumb), -30, -30);
        popMatrix();
      } else if (goingLeft)
      {
        prevRot = 'l';
        pushMatrix();
        translate(posX, posY);
        rotate(radians(270));
        if (interacting)image(interactSprite, -30, 0);
        else image(sprites.get(spriteNumb), -30, 0);
        popMatrix();
      } else if (goingRight)
      {
        prevRot = 'r';
        pushMatrix();
        translate(posX, posY);
        rotate(radians(90));
        if (interacting)image(interactSprite, 0, -30);
        else image(sprites.get(spriteNumb), 0, -30);
        popMatrix();
      }
      if (frameCount > storedFrame+10)
      {
        storedFrame = frameCount;
        spriteNumb++;
        if (spriteNumb == sprites.size()) spriteNumb = 0;
      }
    } else {
      if (prevRot == 'u')
      {
        pushMatrix();
        translate(posX, posY);
        rotate(radians(0));
        if (interacting)image(interactSprite, 0, 0);
        else image(sprites.get(0), 0, 0);
        popMatrix();
      } else if (prevRot == 'd')
      {
        pushMatrix();
        translate(posX, posY);
        rotate(radians(180));
        if (interacting)image(interactSprite, -30, -30);
        else image(sprites.get(0), -30, -30);
        popMatrix();
      } else if (prevRot == 'l')
      {
        pushMatrix();
        translate(posX, posY);
        rotate(radians(270));
        if (interacting)image(interactSprite, -30, 0);
        else image(sprites.get(0), -30, 0);
        popMatrix();
      } else if (prevRot == 'r')
      {
        pushMatrix();
        translate(posX, posY);
        rotate(radians(90));
        if (interacting)image(interactSprite, 0, -30);
        else image(sprites.get(0), 0, -30);
        popMatrix();
      }
    }
  }

  void updatePosition(ArrayList<Wall> wallObjs, ArrayList<LargeObject> desks)
  {
    if (interacting)
    {
      if (frameCount - interactFrameCount < 5) interact();
      interacting = frameCount - interactFrameCount < 10;
    }

    boolean hasGoneUp = false;
    boolean hasGoneDown = false;
    boolean hasGoneLeft = false;
    boolean hasGoneRight = false;
    for (int i = 0; i < wallObjs.size (); i++)
    {
      int wallSX = wallObjs.get(i).startX;
      int wallSY = wallObjs.get(i).startY;
      int wallEX = wallObjs.get(i).endX;
      int wallEY = wallObjs.get(i).endY;

      if (goingUp && !hasGoneUp && posX < wallEX && posX+30 > wallSX && posY-speed <= wallEY && posY > wallEY)
      {
        hasGoneUp = true;
        posY = wallEY+1;
      } 
      if (goingDown && !hasGoneDown && posX < wallEX && posX+30 > wallSX && posY+30+speed >= wallSY && posY+30 < wallSY)
      {
        hasGoneDown = true;
        posY = wallSY-31;
      }
      if (goingLeft && !hasGoneLeft && posX-speed <= wallEX && posX > wallEX && posY < wallEY && posY+30  > wallSY)
      {
        hasGoneLeft = true;
        posX = wallEX+1;
      }
      if (goingRight && !hasGoneRight && posX+30+speed >= wallSX && posX+30 < wallSX && posY < wallEY && posY +30  > wallSY)
      {
        hasGoneRight = true;
        posX = wallSX-31;
      }
    }

    for (int i = 0; i < desks.size (); i++)
    {
      int deskSX = desks.get(i).startX;
      int deskSY = desks.get(i).startY;
      int deskEX = desks.get(i).endX;
      int deskEY = desks.get(i).endY;

      if (goingUp && !hasGoneUp && posX < deskEX && posX+30 > deskSX && posY-speed <= deskEY && posY > deskEY)
      {
        hasGoneUp = true;
        posY = deskEY+1;
      } 
      if (goingDown && !hasGoneDown && posX < deskEX && posX+30 > deskSX && posY+30+speed >= deskSY && posY+30 < deskSY)
      {
        hasGoneDown = true;
        posY = deskSY-31;
      }
      if (goingLeft && !hasGoneLeft && posX-speed <= deskEX && posX > deskEX && posY < deskEY && posY+30 > deskSY)
      {
        hasGoneLeft = true;
        posX = deskEX+1;
      }
      if (goingRight && !hasGoneRight && posX+30+speed >= deskSX && posX+30 < deskSX && posY < deskEY && posY +30  > deskSY)
      {
        hasGoneRight = true;
        posX = deskSX-31;
      }
    }

    for (int i = 0; i < doors.size (); i++)
    {
      int doorSX = doors.get(i).startX;
      int doorSY = doors.get(i).startY;
      int doorEX = doors.get(i).endX;
      int doorEY = doors.get(i).endY;

      if (goingUp && !hasGoneUp && posX < doorEX && posX+30 > doorSX && posY-speed <= doorEY && posY > doorEY)
      {
        hasGoneUp = true;
        posY = doorEY+1;
      } 
      if (goingDown && !hasGoneDown && posX < doorEX && posX+30 > doorSX && posY+30+speed >= doorSY && posY+30 < doorSY)
      {
        hasGoneDown = true;
        posY = doorSY-31;
      }
      if (goingLeft && !hasGoneLeft &&posX-speed <= doorEX && posX > doorEX && posY < doorEY && posY+30  > doorSY)
      {
        hasGoneLeft = true;
        posX = doorEX+1;
      }
      if (goingRight && !hasGoneRight && posX+30+speed >= doorSX && posX+30 < doorSX && posY < doorEY&& posY +30  > doorSY)
      {
        hasGoneRight = true;
        posX = doorSX-31;
      }
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

      if (goingUp && !hasGoneUp && posX <= guardEX && posX+30 >= guardSX && posY-5 <= guardEY && posY > guardEY)
      {
        posY=guardEY+1;
        return;
      }
      if (goingDown && !hasGoneDown && posX <= guardEX && posX+30 >= guardSX && posY+35 >= guardSY && posY+30  < guardSY)
      {
        posY=guardSY-31;
        return;
      }
      if (goingLeft && !hasGoneLeft &&posX-5 <= guardEX && posX > guardEX && posY <= guardEY && posY+30  >= guardSY)
      {
        posX=guardEX+1;
        return;
      }
      if (goingRight && !hasGoneRight && posX+35 >= guardSX && posX+30 < guardSX && posY <= guardEY && posY+30  >= guardSY)
      {
        posX=guardSX-31;
        return;
      }
    }
    if (goingUp && !hasGoneUp) posY-=speed;
    if (goingDown && !hasGoneDown) posY+=speed;
    if (goingLeft && !hasGoneLeft) posX-=speed;
    if (goingRight && !hasGoneRight) posX+=speed;
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
    } else if (key == ' ' && state == true)
    {
      interacting = true;
      interactFrameCount = frameCount;
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
    int guardSX = guard.posX;
    int guardSY = guard.posY;
    int guardEX = guardSX+30;
    int guardEY = guardSY+30;

    if ((goingUp||prevRot=='u') && posX < guardEX && posX+30 > guardSX && posY-5 < guardEY && posY > guardEY)
    {
      return true;
    }
    if ((goingDown||prevRot=='d')  && posX < guardEX && posX+30 > guardSX && posY+35 > guardSY && posY+30  < guardSY)
    {
      return true;
    }
    if ((goingLeft||prevRot=='l') && posX-5 < guardEX && posX > guardEX && posY < guardEY && posY+30  > guardSY)
    {
      return true;
    }
    if ((goingRight||prevRot=='r') && posX+35 > guardSX && posX+30 < guardSX && posY < guardEY && posY+30  > guardSY)
    {
      return true;
    }
    return false;
  }
}