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
  float speed = 5.0;

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

      if (goingUp && canUp && posX < guardEX && posX+30 > guardSX && posY-5 < guardEY && posY+25  > guardSY)
      {
       
        return;
      }
      if (goingDown&& canDown && posX < guardEX && posX+30 > guardSX && posY+5 < guardEY && posY+35  > guardSY)
      {
        
        return;
      }
      if (goingLeft && canLeft && posX-5 < guardEX && posX-5 > guardSX && posY < guardEY && posY +30  > guardSY)
      {
        
        return;
      }
      if (goingRight && canRight && posX+25 < guardEX && posX+25 > guardSX && posY < guardEY && posY +30  > guardSY)
      {
        
        return;
      }
    }


    if (goingUp && canUp) posY-=speed;
    if (goingDown&& canDown) posY+=speed;
    if (goingLeft && canLeft) posX-=speed;
    if (goingRight && canRight) posX+=speed;
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
    //From right
    if ((goingLeft||prevRot=='l')
      && (posX-8) <= (guard.posX+30) 
      && posX-(guard.posX+30) >= 0 
      && posX-(guard.posX+30) <= 8
      && posY < guard.posY+30 
      && posY+30 > guard.posY) return true;
    //From left 
    else if ((goingRight||prevRot=='r') 
      && (posX+38) >= guard.posX 
      && (posX+30)-guard.posX >= 0 
      && (posX+30)-guard.posX <=8 
      && posY < (guard.posY+30)
      && (posY+30) > guard.posY) return true;
    //From bottom
    else if ((goingUp||prevRot=='u') 
      &&(posY-8) <= (guard.posY+30) 
      && posY-(guard.posY+30) >= 0 
      && posY-(guard.posY+30) <= 8
      && posX < (guard.posX+30) && (posX+30) > guard.posX) return true;
    //from top
    else if ((goingDown||prevRot=='d') 
      && (posY+38) >= guard.posY 
      && (posY+30)-guard.posY >= 0 
      && (posY+30)-guard.posY <= 8 
      && posX < (guard.posX+30) 
      && (posX+30) > guard.posX) return true;
    return false;
  }
}