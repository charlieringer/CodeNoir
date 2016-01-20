class LockPuzzle
{
  Door linkedDoor;
  Lockpick lockpick;
  Tumbler tumbler;
  boolean finished;
  int timer;
  int nopins;
  PImage backgroundImage;
  Level parentLevel;

  //CDR: Pins should be an array
  Pins[] pin;


  //CDR: Added constructor
  LockPuzzle(int pins, Door door, Level parentLevel)
  {
    this.parentLevel = parentLevel;
    lockpick = new Lockpick();
    tumbler= new Tumbler();
    finished = false;
    nopins = pins;
    pin = new Pins[nopins];
    //Pins are made here
    for (int i = 0; i < pin.length; i++)
    {
      pin[i] = new Pins(200+(i*20), 100);
    }
    backgroundImage = loadImage("door.jpg");
    backgroundImage.resize(400, 400);
    linkedDoor = door;
  }

  void drawPuzzle()
  {

    background(0);
    image(backgroundImage, 0, 0); 
    textSize(10);
    fill(0, 255, 0);
    text("Move the lockpick using the arrow keys.", 65, 60);
    text("Push all the tumblers into place and then press space to unlock.", 65, 80);
    //CDR: It is wasteful to initalise new object every frame 
    tumbler.drawTumbler();
    lockpick.drawLockpick();
    for (int i= 0; i < pin.length; i++)
    {
      pin[i].move();
      pin[i].drawPin();
    }
    lockpick.move();
    lockpick.intersect(pin);

    //if all pins up
    //press u to unlock door
  }

  boolean checkEnd()
  {
    for (int i= 0; i < pin.length; i++)
    {
      if (!pin[i].waiting)
      {
        return false;
      }
    }
    print("end");
    return true;
  }

  void pressed()
  {
    if (key == ' ')
    {
      if (checkEnd())
      {
        linkedDoor.open();
        parentLevel.levelState = LevelState.LEVEL;
      }
    } else {
      lockpick.pressed();
    }
  }

  void released()
  {
    lockpick.released();
  }

  void win() {
    text("WIN", 65, 80);
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

class Tumbler
{
  void drawTumbler() 
  {
    fill(160);
    noStroke();
    rectMode(CENTER);
    rect(400/2+ 50, 400/2, 150, 200);
    fill(200);
    rect(400/2+ 50, 400/2, 150, 80);
  }
}

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