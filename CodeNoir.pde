import ddf.minim.*;// import minim audio library
StateClass state;
Level level;
Menu menu;
SaveGame save;
PostGame postGame;
CutScreens cutScreens;
Minim minim;
CNAudio audioPlayer;
int currentLevel;
boolean paused;

void setup()
{
  size(1200, 620);
  surface.setTitle("Code Noir");
  PImage titlebaricon = loadImage("data/icon-raw.png");
  surface.setIcon(titlebaricon);
  currentLevel = 1;
  save = new SaveGame(); 
  state = new StateClass();
  menu = new Menu(state);
  postGame = new PostGame(state);
    minim = new Minim(this);// starts minim
  audioPlayer = new CNAudio(minim);
  frameRate(60);
}

void draw()
{
  audioPlayer.playAudio();
  switch(state.state)
  {
  case FRONTEND:
    menu.drawMenu();
    break;
  case CUTSCREENS:
    cutScreens.drawCutScreens();
    break;
  case INGAME:
    level.drawLevel();
    break;
  case POSTGAMEWIN:
    postGame.drawWin();
    break;
  case POSTGAMELOSE:
    postGame.drawLose();
    break;
  }
}
void keyPressed()
{
  if(keyCode==ESC || key == ESC){
    key = TAB;
    keyCode = TAB;
 }
  switch(state.state)
  {
  case FRONTEND:
    menu.handleKey();
    break;
  case CUTSCREENS:
    cutScreens.handleKeys();
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
  if(keyCode==ESC || key == ESC){
    key = 0;
    keyCode = TAB;
 }
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

void keyTyped()
{
  if(keyCode==ESC || key == ESC){
    key = 0;
    keyCode = TAB;
 }
}

void mousePressed()
{
  switch(state.state)
  {
  case FRONTEND:
    menu.handleMouse();
    break;
  case CUTSCREENS:
    cutScreens.handleMouse();
    break;
  case INGAME:
    level.handleMousePressed();
    break;
  case POSTGAMEWIN:
    postGame.handleMouseWin();
    break;
  case POSTGAMELOSE:
    postGame.handleMouseLose();
    break;
  }
}

void mouseReleased()
{
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