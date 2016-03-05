 StateClass state;
Level level;
Menu menu;
SaveGame save;

void setup()
{
  size(1200, 620);
  save = new SaveGame();
  state = new StateClass();
  menu = new Menu(state);
}

void draw()
{
  switch(state.state)
  {
  case FRONTEND:
    menu.drawMenu();
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
  case INGAME:
    level.handleMousePressed();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}

void mouseReleased()
{
  println(mouseX, mouseY);

  switch(state.state)
  {
  case FRONTEND:
    break;
  case INGAME:
    level.handleMouseReleased();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}

void mouseDragged()
{
  switch(state.state)
  {
  case FRONTEND:
    break;
  case INGAME:
    level.handleMouseDragged();
    break;
  case POSTGAMEWIN:
    break;
  case POSTGAMELOSE:
    break;
  }
}