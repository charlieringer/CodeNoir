class LockPuzzle
{
  Lockpick lockpick;
  Tumbler tumbler;
  boolean finished;
  int timer;
  int nopins;
  PImage backgroundImage;

  //CDR: Pins should be an array
  Pins[] pin;


  //CDR: Added constructor
  LockPuzzle(int pins)
  {
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
  }

  void drawPuzzle()
  {
    if (!finished)
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
    } else
    {
      background(128);
      image(backgroundImage, 0, 0);
      fill(0);
      win();
    }
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
      finished = checkEnd();
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