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

class Tumbler
{
  void drawTumbler() 
  {
    fill(160);
    noStroke();
    rectMode(CENTER);
    rect(width/2+ 50, height/2, 150, 200);
    fill(200);
    rect(width/2+ 50, height/2, 150, 80);
  }
}