State state;
Level level;
Menu menu;

void setup()
{
  size(1200, 620);
  state = State.FRONTEND;
  level = new Level();
  menu = new Menu();
}

void draw()
{
  switch(state)
  {
  case FRONTEND:
    menu.drawMenu();
    if(menu.playNew == true) {
      state = State.INGAME;
    }
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
    background(255);
    break;
  case POSTGAMELOSE:
    background(0);
    break;
  }
}


void keyPressed()
{
  switch(state)
  {
  case FRONTEND:
    menu.handleKey();
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

  switch(state)
  {
  case FRONTEND:
    menu.handleMouse();
    break;
  case CONTROLS:
    break;
  case LEVELSELECT:
    break;
  case SETTINGS:
    break;
  case INGAME:
    level.handleMousePressed();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}