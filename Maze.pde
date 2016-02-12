class ServerPuzzle {
  PFont pixel;
  PImage lock, Key;
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
    pixel = createFont("renegado.ttf", 30);
    lock = loadImage("lock.png");
    Key = loadImage("key.png");

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
    background(0);
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
      //println(xpos);
      //println(ypos);
      switch(design.get(i)) {
      case 1:
        keyVect = new PVector(100+(xpos*100), 130+(ypos*100));
        //image(Key, 50+(xpos*100), 90+(ypos*100));
        break;
      case 2:
        lockVect = new PVector(105+(xpos*100), 125+(ypos*100));
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
    fill(0);
    rect(0, 0, 1200, 600);
    stroke(60, 228, 34);
    fill(60, 228, 34);
    textFont(pixel);
    text("YOU WIN!", 500, 250);
  }

  void move()
  {
    for (int i = 0; i < connection.size(); i++)
    {
      connection.get(i).checkAndMove(mouseX, mouseY);
    }
  }
}