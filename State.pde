class StateClass
{
  State state;
  menuState MenuState;
  
  StateClass()
  {
    state = State.FRONTEND;
    MenuState = menuState.INITIAL;
  }
}


enum State {
    FRONTEND, //0
    CONTROLS, //1
    LEVELSELECT, //2
    SETTINGS, //3
    CUTSCREENS, //4
    INGAME, //5
    POSTGAMEWIN, //6
    POSTGAMELOSE //7
}

enum LevelState {
    LEVEL, //0
    TERMINAL, //1
    LOCKPICK, //2
    FINGERPRINT, //3
    CAMERA, //4 
    SERVER, //5
    PAPERS, //6
    PAUSE //7
}

enum menuState {
  INITIAL,
  MAIN,
  CONTINUEMENU,
  CONTROLS,
  SETTINGS
}