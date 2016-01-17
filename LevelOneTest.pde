State state;
Level level;

void setup()
{
  size(1200, 620);
  state = State.INGAME;
  level = new Level();
}

void draw()
{
  switch(state)
  {
  case FRONTEND:
    break;
  case CONTROLS:
    break;
  case LEVELSELECT:
    break;
  case SETTINGS:
    break;
  case INGAME:
    level.drawLevel();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}


void keyPressed()
{
  switch(state)
  {
  case FRONTEND:
    break;
  case CONTROLS:
    break;
  case LEVELSELECT:
    break;
  case SETTINGS:
    break;
  case INGAME:
    level.handleKeyOn();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}

void keyReleased()
{
  switch(state)
  {
  case FRONTEND:
    break;
  case CONTROLS:
    break;
  case LEVELSELECT:
    break;
  case SETTINGS:
    break;
  case INGAME:
    level.handleKeyOff();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}

void mousePressed()
{
  println(mouseX, mouseY);
}
