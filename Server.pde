class Server
{
  int sX, sY, eX, eY;
  PImage dispImage = loadImage("Art_Assets/In_Game/Levels/server.png");
  ServerPuzzle puzzle;
  Level parentLevel;
  boolean complete = false;
  
  Server(int sX, int sY, int eX, int eY, Level parentLevel, String lvl, String win)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
    this.parentLevel = parentLevel;
    puzzle = new ServerPuzzle(lvl, win); 
  }
  
  void drawOnLevel()
  {
    image(dispImage, sX, sY);
  }
  
  void drawOnOwn()
  { 
    if(puzzle.gameWin == false) {
      puzzle.drawMaze();
    } else {  
      if(!complete)
      {
        complete = true;
        parentLevel.player.hasData+=1;
      }
      puzzle.win();
    }
  }
  
  void handleKey()
  {
    if (key == TAB)
    {
      parentLevel.levelState = LevelState.LEVEL;
    }
  }
  
  void handleMousePressed()
  {
    puzzle.move();
  }
}

class ServerPuzzle {
  PFont pixel;
  PImage lock, Key, office, winScreen;
  PVector lockVect, keyVect;
  BufferedReader reader;
  String line;
  IntList design;
  IntList solution;
  int xpos = 0;
  int ypos = 0;
  Boolean gameWin = false;
  int correctCount = 0;
  Boolean[] win = new Boolean[5];

  ArrayList<Wire> wires = new ArrayList<Wire>();
  ArrayList<Connections> connection = new ArrayList<Connections>();
  ArrayList<cornerWire> corners = new ArrayList<cornerWire>();
  String[] separate = new String[55];
  boolean drawn = false;

  ServerPuzzle(String level, String solve) {
    pixel = createFont("Fonts/renegado.ttf", 30);
    lock = loadImage("Art_Assets/In_Game/Server/lock.png");
    Key = loadImage("Art_Assets/In_Game/Server/key.png");
    office = loadImage("Art_Assets/In_Game/Server/office.jpeg");
    winScreen = loadImage("Art_Assets/In_Game/Server/serverWin.png");

    lock.resize(50, 50);
    Key.resize(100, 100);

    reader = createReader(level);
    design = new IntList();
    solution = new IntList();

    readLevel();
    constructLevel();
    readSolution(solve);
  }

  void drawMaze() {
    rectMode(CORNER);
    //init_setup();
    checkWin();
    background(office);
    for (int i = 0; i < wires.size (); i++)
    {
      wires.get(i).drawWire();
    }
    for (int i = 0; i < connection.size(); i++)
    {
      connection.get(i).drawConnections();
    }
    for (int i = 0; i < corners.size(); i++)
    {
      corners.get(i).drawCorner();
    }
    image(Key, keyVect.x, keyVect.y);
    image(lock, lockVect.x, lockVect.y);
    stroke(60, 228, 34);
    fill(60, 228, 34);
    textFont(pixel);
    text("Click to rotate the wires and make a solid connection!", 20, 40);
    //this is the code for the grid- comment out
    for (int i = 0; i < 12; i++) {
      rect(50+(i*100), 75, 1, 500);
    }

    for (int i = 0; i < 6; i++) {
      rect(50, 75+(i*100), 1100, 1);
    }
    noStroke();
  }

  void readLevel() {
    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }

    if (line == null) {
      noLoop();
    } else {
      String[] read = split(line, " ");
      for (int j = 0; j < read.length; j++) {
        design.append(int(read[j]));
      }
    }
  }

  void constructLevel() {
    for (int i = 0; i < design.size(); i++) {
      switch(design.get(i)) {
      case 1:
        keyVect = new PVector(40+(xpos*100), 90+(ypos*100));
        //image(Key, 50+(xpos*100), 90+(ypos*100));
        break;
      case 2:
        lockVect = new PVector(80+(xpos*100), 100+(ypos*100));
        //image(lock, 80+(xpos*100), 100+(ypos*100));
        break;
      case 3:
        connection.add(new Connections((100+(xpos*100)), (125+(ypos*100)), true)); 
        break;
      case 4:
        connection.add(new Connections((100+(xpos*100)), (125+(ypos*100)), false));
        break;
      case 5:
        wires.add(new Wire((50+(xpos*100)), (120+(ypos*100)), 100, 10, true));
        break;
      case 6:
        wires.add(new Wire((100+(xpos*100)), (75+(ypos*100)), 10, 100, true));
        break;
      case 7:
        wires.add(new Wire((50+(xpos*100)), (120+(ypos*100)), 100, 10, false));
        break;
      case 8:
        wires.add(new Wire((100+(xpos*100)), (75+(ypos*100)), 10, 100, false));
        break;
      case 9:
        corners.add(new cornerWire((100+(xpos*100)), (120+(ypos*100)), 10, 55, 1));
        break;
      case 10:
        corners.add(new cornerWire((100+(xpos*100)), (120+(ypos*100)), 10, 55, 2));
        break;
      case 11:
        corners.add(new cornerWire((100+(xpos*100)), (120+(ypos*100)), 10, 55, 3));
        break;
      case 12:
        corners.add(new cornerWire((100+(xpos*100)), (120+(ypos*100)), 10, 55, 4));
        break;
      }
      xpos++;
      if (xpos > 10) {
        ypos++;
      }
      if (xpos > 10) {
        xpos = 0;
      }
      if (ypos > 4) {
        ypos = 0;
      }
    }
  }

  void readSolution(String s) {
    String lines[] = loadStrings(s);
    for (int i = 0; i < lines.length; i++) {
      solution.append(int(lines[i]));
    }
  }

  void checkWin() {
    for (int i = 0; i < connection.size(); i++) {
      if (connection.get(i).checkCorrect(solution.get(i)) == true) {
        win[i] = true;
      } else {
        win[i] = false;
      }
    }
    if ((win[0] && win[1] && win[2] && win[3] && win[4]) == true) {
      gameWin = true;
    }
    println(gameWin);
  }

  void win() {
    image(winScreen, 300, 160);
  }

  void move()
  {
    for (int i = 0; i < connection.size(); i++)
    {
      connection.get(i).checkAndMove(mouseX, mouseY);
    }
  }
}

class Connections {
  PImage[] arrow;
  int arrow_pos; 
  int posX, posY;
  boolean corner;
  
  Connections(int posX, int posY, boolean corner) {
    this.posX = posX;
    this.posY = posY;
    this.corner = corner;
    
    String server = "Art_Assets/In_Game/Server/arrow/";
    String[] files = new String[8];
    for (int i = 0; i < files.length; i++)
    {
      files[i] = server + (i+1)+".png";
    }
    arrow = new PImage[files.length];
    for (int i = 0; i < files.length; i++)
    {
      arrow[i] = loadImage(files[i]);
      arrow[i].resize(80, 80);
    }
    if(corner == true)
    {
      arrow_pos = 0;
    } else { 
      arrow_pos = 4;
    }
  }

  void drawConnections() {
    if(corner == true)
    {
      if(arrow_pos >= 4)
      {
        arrow_pos = 0;
      }
    } 
    else {
      if(arrow_pos >= 8)
      {
        arrow_pos = 4;
      }
    }
    
    imageMode(CENTER);
    image(arrow[arrow_pos], posX, posY);
    imageMode(CORNER);
  }
  
  Boolean checkCorrect(int current_pos) {
    if(arrow_pos == current_pos) {
      return true;
    } else {
      return false;
    }
  }
  
  void checkAndMove(int x, int y)
  {
    if (x > posX - 40 && x < posX + 40 && y > posY - 40 && y < posY + 40)
    {
      arrow_pos++;
    }
  }
}

class cornerWire {
  int startX, startY, w, h;
  int position;
  
  cornerWire(int startX, int startY, int w, int h, int position) {
    this.startX = startX;
    this.startY = startY;
    this.w = w;
    this.h = h;
    this.position = position;
  }
  
  void drawCorner() {
    fill(60, 228, 34);
    switch(position) {
      case 1:
        rect(startX, startY, w, h);
        rect(startX, startY, h, w);
        break;
      case 2:
        rect(startX, startY, w, h);
        rect(startX, startY, -h, w);
        break;
      case 3:
        rect(startX, startY-45, w, h);
        rect(startX, startY, -h+5, w);
        break;
      case 4:
        rect(startX, startY, w, -h+10);
        rect(startX, startY, h-5, w);
        break;
    }
  }
}

class Wire {
  int startX, startY, w, h;
  int hor_power;
  int vert_power;
  boolean forward = true, move = false;

  Wire(int startX, int startY, int w, int h, boolean forward) {
    this.startX = startX;
    this.startY = startY;
    this.w = w;
    this.h = h;
    this.forward = forward;
  }

  void drawWire() {
    fill(60, 228, 34);
    rect(startX, startY, w, h);
    fill(255);
  }
}