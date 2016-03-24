class LockPuzzle
{
  Door linkedDoor;
  Lockpick lockpick;
  boolean finished;
  int timer;
  int nopins;
  PImage backgroundImage, office, lock;
  Level parentLevel;

  //CDR: Pins should be an array
  Pins[] pin;


  //CDR: Added constructor
  LockPuzzle(int pins, Door door, Level parentLevel)
  {
    this.parentLevel = parentLevel;
    lockpick = new Lockpick();
    finished = false;
    nopins = pins;
    pin = new Pins[nopins];
    //Pins are made here
    for (int i = 0; i < pin.length; i++)
    {
      pin[i] = new Pins(489+(i*26), 175);
    }
    backgroundImage = loadImage("Art_Assets/In_Game/Lockpick/door.png");
    backgroundImage.resize(600, 500);
    office = loadImage("Art_Assets/In_Game/Lockpick/office.jpeg");
    office.resize(1200, 620);
    lock = loadImage("Art_Assets/In_Game/Lockpick/lockpickbg.png");
    lock.resize(508,333);
    linkedDoor = door;
    
  }

  void drawPuzzle()
  {
    background(office);
    image(backgroundImage, 300, 70); 
    image(lock, 345, 160);
    textSize(20);
    fill(255);
    text("Move the lockpick using the arrow keys.", 325, 40);
    text("Push all the tumblers into place and then press space to unlock.", 150, 70);
    //CDR: It is wasteful to initalise new object every frame 
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
  float pinHeight = 150;
  boolean pushedUp;
  boolean waiting = false;
  int waitTime;
  PImage pinImage = loadImage("Art_Assets/In_Game/Lockpick/barrel.png");

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
    //rect(pinX, pinY, pinWidth, pinHeight);
    image(pinImage,pinX,pinY);
    stroke(0);
  }

  void move()
  {
    if (pinY > 225 && !pushedUp) return;
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
    if (pinY < 110)
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

class Lockpick 
{
  PImage lockpickimage = loadImage("Art_Assets/In_Game/Lockpick/lockpick.png");
  // image credit: http://abstract.desktopnexus.com/wallpaper/699441/
  // lockpick position variables
  float posX = 325;
  float posY = 280;
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
    if (up && posY > 245) posY -= 1.5;
    if (down && posY < 360) posY +=1.5;
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