//Class for a guard object //<>//
//Constructor: takes a starting X and Y (top left corner) and a char (u,d,l,r) for the heading and a turn char (b = backwards, l = left, r = right)
//drawGuard: takes no params and draws the guard to the screen
//moveGuard: takes the array of walls and hard objects and moves the guard based on these
//checkForPlayer: take the player and array of walls and returns true if the guard can see the player

class Guard
{
  int posX;
  int posY;
  char heading; 
  char turn;
  boolean alive = true;

  Guard(int posX, int posY, char heading, char turn)
  {
    this.posX = posX;
    this.posY = posY;
    this.heading = heading;
    this.turn = turn;
  }

  public void drawGuard()
  {
    if (alive)
    {
      fill(255, 0, 0);
      rect(posX, posY, 30, 30);
    } else 
    {
      fill(255, 0, 255);
      rect(posX, posY, 30, 30);
    }
  }

  public void moveandDrawGuard(ArrayList<Wall> wallObjs, ArrayList<LargeObject> desks)
  {
    if (!alive) return;
    if (heading == 'u') posY-=2; 
    else if (heading == 'd') posY+=2;
    else if (heading == 'l') posX-=2;
    else if (heading == 'r') posX+=2;

    for (int i = 0; i < wallObjs.size (); i++)
    {
      int wallSX = wallObjs.get(i).startX;
      int wallSY = wallObjs.get(i).startY;
      int wallEX = wallObjs.get(i).endX;
      int wallEY = wallObjs.get(i).endY;

      if (posX < wallEX && posX+30 > wallSX && posY <= wallEY && posY+2 > wallEY && heading == 'u') 
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
      if (posX < wallEX && posX+30 > wallSX && posY+30 >= wallSY && posY+28 < wallSY && heading == 'd')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
      if (posY < wallEY && posY+30 > wallSY && posX <= wallEX && posX+2 > wallEX  && heading == 'l')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
      if (posY < wallEY && posY+30 > wallSY && posX+30 >= wallSX && posX+28 < wallSX && heading == 'r')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
    }

    for (int i = 0; i < desks.size (); i++)
    {
      int deskSX = desks.get(i).startX;
      int deskSY = desks.get(i).startY;
      int deskEX = desks.get(i).endX;
      int deskEY = desks.get(i).endY;

      if (posX < deskEX && posX+30 > deskSX && posY <= deskEY && posY+2 > deskEY && heading == 'u')

      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }      
      if (posX < deskEX && posX+30 > deskSX && posY+30 >= deskSY && posY+28 < deskSY && heading == 'd')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
      if (posY < deskEY && posY+30 > deskSY && posX <= deskEX && posX+2 > deskEX  && heading == 'l')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
      if (posY < deskEY && posY+30 > deskSY && posX+30 >= deskSX && posX+28 < deskSX && heading == 'r')
      {
        if (turn == 'b') turnAround();
        else if ( turn == 'l') turnLeft();
        else if ( turn == 'r') turnRight();
      }
    }
    
    if (alive)
    {
      fill(255, 0, 0);
      rect(posX, posY, 30, 30);
    } else 
    {
      fill(255, 0, 255);
      rect(posX, posY, 30, 30);
    }
  }

  private void turnAround()
  {
    if (heading == 'u') heading = 'd'; 
    else if (heading == 'd') heading = 'u'; 
    else if (heading == 'l') heading = 'r'; 
    else if (heading == 'r') heading = 'l';
  }

  private void turnLeft()
  {
    if (heading == 'u') heading = 'l'; 
    else if (heading == 'd') heading = 'r'; 
    else if (heading == 'l') heading = 'd'; 
    else if (heading == 'r') heading = 'u';
  }

  private void turnRight()
  {
    if (heading == 'u') heading = 'r'; 
    else if (heading == 'd') heading = 'l'; 
    else if (heading == 'l') heading = 'u'; 
    else if (heading == 'r') heading = 'd';
  }

  public boolean checkForPlayer(Player player, ArrayList<Wall> wallObjs)
  {
    if (!alive) return false;
    int visionSX;
    int visionSY;
    int visionEX;
    int visionEY;
    if (heading == 'u')
    {

      visionSY = visionEY = posY;
      visionSX = posX;
      visionEX = posX+30;

      boolean finished = false;  
      int testCount = 0;
      while (!finished)
      {
        testCount++;
        if (visionEY <= player.posY+30 && visionSY > player.posY+30 && 
          ((player.posX+15) > visionSX) && ((player.posX+15) < visionEX) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
          player.drawPlayer();
          println("SPOTTED");
          return true;
        }
        for (int i = 0; i < wallObjs.size (); i++)
        {
          int wallSX = wallObjs.get(i).startX;
          int wallEY = wallObjs.get(i).endY;
          int wallEX = wallObjs.get(i).endX;
          if (visionEX < wallEX && visionEX > wallSX && visionSY > wallEY && visionEY <= wallEY)
          {
            fill(255, 255, 0, 75);
            rectMode(CORNERS);
            noStroke();
            rect(visionSX, visionSY, visionEX, visionEY);
            player.drawPlayer();
            return false;
          }
          if (testCount > 1000)
          {
            println("We have a problem here");
            return false;
          }
        }
        visionEY--;
      }
    } else if (heading == 'd') 
    {
      visionSY = visionEY = posY+30;
      visionSX = posX;
      visionEX = posX+30;

      boolean finished = false;  
      int testCount = 0;
      while (!finished)
      {
        testCount++;
        if (visionEY >= player.posY && visionSY < player.posY && 
          ((player.posX+15) > visionSX) && ((player.posX+15) < visionEX) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
          println("SPOTTED");
          return true;
        }
        for (int i = 0; i < wallObjs.size (); i++)
        {
          int wallSY = wallObjs.get(i).startY;
          int wallSX = wallObjs.get(i).startX;
          int wallEX = wallObjs.get(i).endX;
          if (visionEX < wallEX && visionEX > wallSX && visionSY < wallSY && visionEY >= wallSY)
          {
            fill(255, 255, 0, 75);
            rectMode(CORNERS);
            noStroke();
            rect(visionSX, visionSY, visionEX, visionEY);
            player.drawPlayer();
            return false;
          }
          if (testCount > 1000)
          {
            println("We have a problem here");
            return false;
          }
        }
        visionEY++;
      }
      return false;
    } else if (heading == 'l')
    {
      visionSX = visionEX = posX;
      visionSY = posY;
      visionEY = posY+30;

      boolean finished = false;  
      int testCount = 0;
      while (!finished)
      {
        testCount++;
        if (visionEX <= player.posX+30 && visionSX > player.posX+30 && 
          ((player.posY+15) > visionSY) && ((player.posY+15) < visionEY) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
          player.drawPlayer();
          println("SPOTTED");
          return true;
        }
        for (int i = 0; i < wallObjs.size (); i++)
        {
          int wallSY = wallObjs.get(i).startY;
          int wallEX = wallObjs.get(i).endX;
          int wallEY = wallObjs.get(i).endY;
          if (visionEY < wallEY && visionEY > wallSY && visionSX > wallEX && visionEX <= wallEX)
          {
            fill(255, 255, 0, 75);
            rectMode(CORNERS);
            noStroke();
            rect(visionSX, visionSY, visionEX, visionEY);
            player.drawPlayer();
            return false;
          }
          if (testCount > 1000)
          {
            println("We have a problem here");
            return false;
          }
        }
        visionEX--;
      }
    } else if (heading == 'r')
    {
      visionSX = visionEX = posX+30;
      visionSY = posY;
      visionEY = posY+30;

      boolean finished = false;  
      int testCount = 0;
      while (!finished)
      {
        testCount++;
        if (visionEX >= player.posX && visionSX < player.posX && 
          ((player.posY+15) > visionSY) && ((player.posY+15) < visionEY) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
          println("SPOTTED");
          return true;
        }
        for (int i = 0; i < wallObjs.size (); i++)
        {
          int wallSX = wallObjs.get(i).startX;
          int wallSY = wallObjs.get(i).startY;
          int wallEY = wallObjs.get(i).endY;
          if (visionEY < wallEY && visionEY > wallSY && visionSX < wallSX && visionEX >= wallSX)
          {
            fill(255, 255, 0, 75);
            rectMode(CORNERS);
            noStroke();
            rect(visionSX, visionSY, visionEX, visionEY);
            player.drawPlayer();
            return false;
          }
          if (testCount > 1000)
          {
            println("We have a problem here");
            return false;
          }
        }
        visionEX++;
      }
    }
    println("Fell out the bottom.");
    return false;
  }
}