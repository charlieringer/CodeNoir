class StateClass
{
  State state;
  
  StateClass()
  {
    state = State.FRONTEND;
  }
}


enum State {
    FRONTEND, //0
    CONTROLS, //1
    LEVELSELECT, //2
    SETTINGS, //3
    INGAME, //4
    POSTGAMEWIN, //5
    POSTGAMELOSE //6
}

enum LevelState {
    LEVEL, //0
    TERMINAL, //1
    LOCKPICK, //2
    FINGERPRINT, //3
    CAMERA, //4 
    SERVER, //5
    PAPERS //6
}

enum menuState {
  INITIAL,
  MAIN,
  CONTINUEMENU,
  CONTROLS,
  SETTINGS
}