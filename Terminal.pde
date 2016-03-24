class Terminal
{
  HackPuzzle puzzle;
  ArrayList<Subroutine> subroutines;
  //Bachround image (placeholder currently)
  PImage office = loadImage("Art_Assets/In_Game/Terminal/office.jpeg");
  PImage backgroundImage = loadImage("Art_Assets/In_Game/Terminal/computer.png");
  PFont compFont = createFont("Fonts/Chava-Regular.ttf", 10);
  int selected = 0;

  Level parentLevel;
  Door linkedDoor;
  SecurityCamera linkedCamera;
  StringList dataStrings = new StringList();
  boolean drawingData = false;

  Terminal(int codeLength, Level level, Door door, SecurityCamera cam, String dataPath)
  {
    puzzle = new HackPuzzle(codeLength);
    subroutines = new ArrayList<Subroutine>();
    parentLevel = level;

    linkedDoor = door;
    if (door != null) subroutines.add(new DoorSubroutine(door));

    linkedCamera = cam;
    if (linkedCamera != null) subroutines.add(new CameraSubroutine(cam));

    if (dataPath != null)
    {
      String data[] = loadStrings(dataPath);
      for (String line : data) {
        dataStrings.append(line);
      }
      subroutines.add(new DataSubroutine(this));
    }
  }

  Terminal(int codeLength, Level level, Door door) { 
    this(codeLength, level, door, null, null);
  }
  Terminal(int codeLength, Level level, SecurityCamera cam) { 
    this(codeLength, level, null, cam, null);
  }
  Terminal(int codeLength, Level level, String data ) { 
    
    this(codeLength, level, null, null, data);
  }

  Terminal(int codeLength, Level level, Door door, SecurityCamera cam ) { 
    this(codeLength, level, door, cam, null);
  }
  Terminal(int codeLength, Level level, Door door, String data ) { 
    this(codeLength, level, door, null, data);
  }
  Terminal(int codeLength, Level level, SecurityCamera cam, String data ) { 
    this(codeLength, level, null, cam, data);
  }

  void drawTerminal()
  {
    image(office,0, 0);
    image(backgroundImage, 360, 0);
    if (!puzzle.finished)
    {
      puzzle.drawGame();
    } else if (drawingData)
    {
      textFont(compFont);
      fill(0,255,0);
      for (int i = 0; i < dataStrings.size(); i++)
      {
        
        text(dataStrings.get(i), 450, (20*i)+80);
      }
      text("TAB to return.", 450, 269);
    } else 
    {
      textFont(compFont);
      textSize(10);
      noStroke();
      fill(0, 255, 0);
      text("Welcome USER, please select function: ", 450, 70);
      drawSubroutines();
      fill(0,255,0);
      text("TAB to quit terminal.", 450, 269);
    }
  }

  void checkKey()
  {
    if (key == TAB)
    {
      if (drawingData) drawingData = false;
      else parentLevel.levelState = LevelState.LEVEL;
    }
    if (!puzzle.finished)
    {
      puzzle.checkKey();
    } else {
      if (key == ENTER)
      {
        subroutines.get(selected).execute();
      } else if (key == CODED)
      {
        if (keyCode == UP ||keyCode == DOWN)
        {
          selectSubroutine();
        }
      }
    }
  }

  void selectSubroutine()
  {
    if (keyCode == UP)
    {
      if (selected > 0)
      {
        selected--;
      }
    } else if (keyCode == DOWN) {
      if (selected < subroutines.size()-1)
      {
        selected++;
      }
    }
  }
  void drawSubroutines()
  {
    rectMode(CORNER);
    for (int i = 0; i < subroutines.size (); i++)
    {
      // background(0);
      int x = 470;
      int y = 90 +(i*12);
      if (i==selected)
      {
        rect(x, y-10, 100, 12);
        fill(0);
      } else {
        fill(0, 255, 0);
      }
      subroutines.get(i).drawSubroutine(x, y);
    }
  }
  class Subroutine
  {
    String title;

    void drawSubroutine(int x, int y) {
    }
    void execute() {
    }
  }

  class DoorSubroutine extends Subroutine
  {
    Door linkedDoor;
    DoorSubroutine(Door linkedDoor) 
    {
      this.linkedDoor = linkedDoor;
    }

    void drawSubroutine(int x, int y)
    {
      assert(linkedDoor != null);
      if (linkedDoor.locked)
      {
        text("Unlock door", x, y);
      } else {
        text("Lock door", x, y);
      }
    }
    void execute()
    {
      if (linkedDoor.locked) linkedDoor.open();
      else linkedDoor.close();
    }
  }

  class CameraSubroutine extends Subroutine
  {

    SecurityCamera linkedCam;
    CameraSubroutine(SecurityCamera linkedCam) 
    {
      this.linkedCam = linkedCam;
    }

    void drawSubroutine(int x, int y)
    {
      assert(linkedCam != null);
      if (linkedCam.on)
      {
        text("Turn off camera", x, y);
      } else {
        text("Turn on camera", x, y);
      }
    }
    void execute()
    {
      linkedCam.on = !linkedCam.on;
    }
  }


  class DataSubroutine extends Subroutine
  {
    Terminal parentTerm;
    DataSubroutine(Terminal parent) {
      parentTerm = parent;
    }
    void drawSubroutine(int x, int y)
    {
      text("Read File", x, y);
    }

    void execute()
    {
      parentTerm.drawingData = true;
    }
  }
}

class HackPuzzle
{
  //We store most of the data in custom containers (for easy adding/manipulating)
  //Code for these classes can be found at the bottom of this class
  Guess guess;
  GuessList previousGuesses;
  Code code;
  PFont compFont = createFont("Fonts/Chava-Regular.ttf", 10);

  //This tell us is the code is cracked or not
  boolean finished;
  //Becasue we want this class to be modualar (for a range of diffuclty) we store the length and the range of ints that can appear
  int codeLength;
  int startRange;
  int endRange;

  HackPuzzle(int codelength)
  {
    //Standard setting of these vals based on what is passed in to the constuctor
    codeLength = codelength;
    startRange = 1;
    endRange = 4;
    //Initialise all of the data
    guess = new Guess();
    previousGuesses = new GuessList();
    code = new Code(codelength, startRange, endRange);
    //We have not finished yet
    finished = false;
  }

  void drawGame()
  {
    textFont(compFont);
    //Placeholder code to just show the game
    //Will need rewriting
    drawInfomation();
    drawGuess();
    //checkFinished returns a bool so we can just check if we are done like this
    finished = checkFinished();
  }

  void drawInfomation()
  {
    //Placeholder info
    textSize(10);
    fill(0, 255, 0);
    text("Enter "+ codeLength + " digit Employee Code:", 450, 70);
    text("Range: "+startRange+"-"+endRange, 450, 80);
    text("Employee reminder: Type using the keyboard.", 450, 245);
    text("Backspace to delete.", 450, 257);
    text("TAB to quit terminal.", 450,269);
  }

  void drawGuess()
  {
    rectMode(CORNER);
    //Place holder but the logic is ok

    //Loop through the length of the code and draw a rect
    for (int i = 0; i < codeLength; i++)
    {
      fill(128);
      noStroke();
      rect(i*30+460, 123, 24, 34);
    }
    //Not sure why I copied the int list over from the guess object. Maybe for readablity?
    IntList currentGuess = guess.getGuess();
    for (int i = 0; i < currentGuess.size (); i++)
    {
      //Prints the guess over the rects earlier
      textSize(30);
      fill(0, 255, 0);
      text(currentGuess.get(i), i*30+460, 150);
    }
    previousGuesses.displayGuesses(code.getCode());
  }

  void checkKey()
  {
    //This checks the key and added a guess or removes one

    //Loop through the range of values the code could be
    for (int i = startRange; i<endRange+1; i++)
    {
      //Cast i to a char 48 places later (becasue ASCII). Don't ask...
      char curr = (char)(i+48);
      //If we pressed that key
      if (key == curr)
      {
        //Add i to the guess
        guess.getGuess().append(i);
        //and we are done here
        return;
      }
    }
    //If backspace was pressed
    if (key == BACKSPACE)
    {
      //remove the guess
      guess.removeLastGuess();
      return;
    }
  }

  boolean checkFinished()
  {
    //Cope the current guess
    IntList currGuess = guess.getGuess();
    //store its size
    int guessSize = currGuess.size();
    //get the code size as well
    int codeSize = code.getCode().length;
    //if these are different we cannot have a match
    if (guessSize < codeSize)
    {
      //so return false
      return false;
    }
    //if we got this far then we have a full guess so reset the old one
    resetGuess();
    //loop through the code
    for (int i = 0; i<codeLength; i++)
    {
      //compare each element
      if (currGuess.get(i) != code.getCode()[i])
      {
        //if we have any mismatch the code failed so return false;
        return false;
      }
    }
    //Wow, we got all the way to the end? Guess the code is good then. Return true. Welldone user!
    return true;
  }

  void resetGuess()
  {
    //Adds the guess to the list of old guesses
    previousGuesses.addGuess(guess.getGuess());
    //then clears the guess
    guess.resetGuess();
  }

  //Below are the three classes that hold all of the data

  class Guess
  {
    //stored as an intlist
    IntList guessList;

    Guess()
    {
      //just makes a new list
      guessList = new IntList();
    }

    IntList getGuess()
    {
      //returns the list
      return guessList;
    }

    void resetGuess()
    {
      //resets to a new list
      guessList = new IntList();
    }

    void removeLastGuess()
    {
      //if we have at least one entry remove the last one
      if (guessList.size () > 0)
      {
        guessList.remove(guessList.size()-1);
      }
    }
  }

  class GuessList
  {
    //This is an array list of intlists (the guesses)
    ArrayList<IntList> prevGuesses;  

    GuessList()
    {
      //Makes a new ArrayList
      prevGuesses = new ArrayList<IntList>();
    }

    void addGuess(IntList guess)
    {
      //Takes a guess and adds it to th guess list
      prevGuesses.add(guess);
    }

    void displayGuesses(int[] currentCode)
    {
      //This prints the guesses out with some weird code
      //CBA to explain it as it will need rewriting in the real version
      for (int i = 0; i <  11; i++)
      {
        if (i >= prevGuesses.size())
        {
          break;
        }
        textSize(10);
        fill(0, 255, 0);
        text("Code: ", 640, i*15+80);
        int correct = 0;
        int lastIntX = 0; 
        for (int j = 0; j < codeLength; j++) 
        {
          int currGuess = prevGuesses.get(prevGuesses.size()-1-i).get(j);
          lastIntX = 678+(j*7);
          text(currGuess, lastIntX, i*15+80);
          if (currGuess == currentCode[j])
          {
            correct++;
          }
        }
        text("Correct: " + correct, lastIntX+10, i*15+80);
      }
    }
  }

  class Code
  {
    //Stored as an array (as the size never changes)
    int[] codeArray;
    Code(int size, int start, int end)
    {
      //We take the size to set the size of the array
      codeArray = new int[size];
      for (int i = 0; i < codeArray.length; i++)
      {
        //then for each element in the array we add a random in within the boundaries passed in
        codeArray[i] = int(random(start, end+1));
      }
    }
    int[] getCode()
    {
      //Just returns the code
      return codeArray;
    }
    void resetCode(int size, int start, int end)
    {
      //Not currently used but we could
      if (size == -1)
      {
        //if we pass -1 as the size then the array is the same size
        size = codeArray.length;
      }
      //this mimics the constuctor
      codeArray = new int[size];
      for (int i = 0; i < codeArray.length; i++)
      {
        codeArray[i] = int(random(start, end+1));
      }
    }
  }
}