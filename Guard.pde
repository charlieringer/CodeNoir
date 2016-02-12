//Class for a guard object //<>// //<>//
//Constructor: takes a starting X and Y (top left corner) and a char (u,d,l,r) for the heading and a turn char (b = backwards, l = left, r = right)
//drawGuard: takes no params and draws the guard to the screen
//moveGuard: takes the array of walls and hard objects and moves the guard based on these
//checkForPlayer: take the player and array of walls and returns true if the guard can see the player

class Guard
{
  int posX;
  int posY;
  String heading; 
  String turn;
  boolean alive = true;

  Guard(int posX, int posY, String heading, String turn)
  {
    this.posX = posX;
    this.posY = posY;
    this.heading = heading;
    this.turn = turn;
  }

  public void moveandDrawGuard(ArrayList<Wall> wallObjs, ArrayList<LargeObject> desks)
  {
    if (!alive)
    {
      rectMode(CORNER);
      fill(255, 0, 255);
      rect(posX, posY, 30, 30);
      return;
    } else {
      if (heading.equals("u")) posY-=2; 
      else if (heading.equals("d")) posY+=2;
      else if (heading.equals("l")) posX-=2;
      else if (heading.equals("r")) posX+=2;

      for (int i = 0; i < wallObjs.size (); i++)
      {
        int wallSX = wallObjs.get(i).startX;
        int wallSY = wallObjs.get(i).startY;
        int wallEX = wallObjs.get(i).endX;
        int wallEY = wallObjs.get(i).endY;

        if (posX < wallEX && posX+30 > wallSX && posY <= wallEY && posY+2 > wallEY && heading.equals("u")) 
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
        if (posX < wallEX && posX+30 > wallSX && posY+30 >= wallSY && posY+28 < wallSY && heading.equals("d"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
        if (posY < wallEY && posY+30 > wallSY && posX <= wallEX && posX+2 > wallEX  && heading.equals("l"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
        if (posY < wallEY && posY+30 > wallSY && posX+30 >= wallSX && posX+28 < wallSX && heading.equals("r"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
      }

      for (int i = 0; i < desks.size (); i++)
      {
        int deskSX = desks.get(i).startX;
        int deskSY = desks.get(i).startY;
        int deskEX = desks.get(i).endX;
        int deskEY = desks.get(i).endY;

        if (posX < deskEX && posX+30 > deskSX && posY <= deskEY && posY+2 > deskEY && heading.equals("u"))

        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }      
        if (posX < deskEX && posX+30 > deskSX && posY+30 >= deskSY && posY+28 < deskSY && heading.equals("d"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
        if (posY < deskEY && posY+30 > deskSY && posX <= deskEX && posX+2 > deskEX  && heading.equals("l"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
        if (posY < deskEY && posY+30 > deskSY && posX+30 >= deskSX && posX+28 < deskSX && heading.equals("r"))
        {
          if (turn.equals("b")) turnAround();
          else if ( turn.equals("l")) turnLeft();
          else if ( turn.equals("r")) turnRight();
        }
      }
      rectMode(CORNER);
      fill(255, 0, 0);
      rect(posX, posY, 30, 30);
    }
  }


  private void turnAround()
  {
    if (heading.equals("u")) heading = "d"; 
    else if (heading.equals("d")) heading = "u"; 
    else if (heading.equals("l")) heading = "r"; 
    else if (heading.equals("r")) heading = "l";
  }

  private void turnLeft()
  {
    if (heading.equals("u")) heading = "l"; 
    else if (heading.equals("d")) heading = "r"; 
    else if (heading.equals("l")) heading = "d"; 
    else if (heading.equals("r")) heading = "u";
  }

  private void turnRight()
  {
    if (heading.equals("u")) heading = "r"; 
    else if (heading.equals("d")) heading = "l"; 
    else if (heading.equals("l")) heading = "u"; 
    else if (heading.equals("r")) heading = "d";
  }

  public boolean checkForPlayer(Player player, ArrayList<Wall> wallObjs)
  {
    if (!alive) return false;
    int visionSX;
    int visionSY;
    int visionEX;
    int visionEY;
    if (heading.equals("u"))
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
          ((player.posX+30) > visionSX) && ((player.posX) < visionEX) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
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
            return false;
          }
          if (testCount > 1000)
          {
            return false;
          }
        }
        visionEY--;
      }
    } else if (heading.equals("d")) 
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
          ((player.posX+30) > visionSX) && ((player.posX) < visionEX) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
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
            return false;
          }
          if (testCount > 1000)
          {
            return false;
          }
        }
        visionEY++;
      }
      return false;
    } else if (heading.equals("l"))
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
          ((player.posY+30) > visionSY) && ((player.posY) < visionEY) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY); 
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
            return false;
          }
          if (testCount > 1000)
          {
            return false;
          }
        }
        visionEX--;
      }
    } else if (heading.equals("r"))
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
          ((player.posY+30) > visionSY) && ((player.posY) < visionEY) ) 
        {
          fill(255, 255, 0, 75);
          rectMode(CORNERS);
          noStroke();
          rect(visionSX, visionSY, visionEX, visionEY);
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
            return false;
          }
        }
        visionEX++;
      }
    }
    return false;
  }
}