StateClass state;
Level level;
Menu menu;

void setup()
{
  size(1200, 620);
  state = new StateClass();
  level = new Level("Levels/Level_1/testlevel.xml");
  menu = new Menu(state);
}

void draw()
{
  switch(state.state)
  {
  case FRONTEND:
    menu.drawMenu();
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
  switch(state.state)
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
  switch(state.state)
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

  switch(state.state)
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