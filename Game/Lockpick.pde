class Lockpick 
{
  PImage lockpickimage = loadImage("lockpick.png");
  // image credit: http://abstract.desktopnexus.com/wallpaper/699441/
  // lockpick position variables
  float posX = 0;
  float posY = height/2;
  float pointOffSetX = 200;
  float pointOffSetY = 62;
  boolean up, down, left, right = false;

  boolean touching = false;

  void drawLockpick() 
  {
    image(lockpickimage, posX, posY);
    lockpickimage.resize(200, 30);
  }

  void move()
  {
    if (up && posY > 150) posY -= 1.5;
    if (down && posY < 225) posY +=1.5;
    if (right) posX += 1.5;
    if (left) posX -=1.5;
  }

  void pressed()
  { 
    if (key == CODED)
    {
      if (keyCode == UP && posY > 50) up = true;
      else if (keyCode == DOWN) down = true;
      else if (keyCode == LEFT) left = true;
      else if (keyCode == RIGHT) right = true;
    }
  }

  void released()
  { 
    if (key == CODED)
    {
      if (keyCode == UP) up = false;
      else if (keyCode == DOWN) down = false;
      else if (keyCode == LEFT) left = false;
      else if (keyCode == RIGHT) right = false;
    }
  }


  void intersect(Pins[] pinArray) 
  { //check if it is in the same position of any of the pins
    float pointX = posX + pointOffSetX;
    float pointY = posY + pointOffSetY;
    for (int i = 0; i < pinArray.length; i++)
    {
      float pinX = pinArray[i].pinX;
      float pinWidth = pinX+pinArray[i].pinWidth;

      float pinHeight = (pinArray[i].pinY+pinArray[i].pinHeight)+50;

      if (pointX > pinX && pointX < pinWidth && pointY > pinHeight-10 && pointY < pinHeight)
      {
        pinArray[i].pushedUp = true;
      } else pinArray[i].pushedUp = false;
    }
  }
}

class Pins 
{
  float pinX;
  float pinY;
  float pinWidth = 12;
  float pinHeight = 100;
  boolean pushedUp = false;
  boolean waiting = false;
  int waitTime;

  //CDR: Added constructor
  Pins(int x, int y)
  {
    pinX = x;
    pinY = y;
    pushedUp = false;
  }

  void drawPin()
  {
    fill(60);
    noStroke();
    rectMode(CORNER);
    rect(pinX, pinY, pinWidth, pinHeight);
  }

  void move()
  {
    if (pinY >140 && !pushedUp) return;
    if (waiting)
    {
      if (millis() >= waitTime)
      {
        waiting = false;
        return;
      } else {
        return;
      }
    } else {
      if (pushedUp)up(); 
      else down();
    }
  }

  void up()
  {
    pinY -= 1.5;
    if (pinY < 70)
    {
      waiting = true;
      waitTime = ((int)random(8000, 10000))+millis();
    }
  }

  void down()
  {
    pinY += 0.05;
  }
}