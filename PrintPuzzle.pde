class PrintPuzzle
{
  FullPiece print;

  ArrayList<PartialPiece> partialChoice;
  ArrayList<BlankPiece> blankPiece;

  boolean completed = false;
  StringList full = new StringList();
  IntList partial = new IntList();
  int pos;
  boolean UL, UR, ML, MR, DL, DR = false;

  PrintPuzzle()
  {
    full.append("arch");
    full.append("loop");
    full.append("whorl");

    for (int i = 1; i < 19; i++) {
      partial.append(i);
    }

    pos = (int)random(0, 3);
    print = new FullPiece(200, 50, "Art_Assets/In_Game/Fingerprint/" + full.get(pos) + ".jpg");

    blankPiece = new ArrayList<BlankPiece>();
    
    blankPiece.add(new BlankPiece(600, 50, 16)); //UL index 0
    blankPiece.add(new BlankPiece(600, 150, 16)); //UR index 1
    blankPiece.add(new BlankPiece(700, 50, 16)); //ML index 2
    blankPiece.add(new BlankPiece(700, 150, 16)); //MR index 3
    blankPiece.add(new BlankPiece(600, 250, 16)); //DL index 4
    blankPiece.add(new BlankPiece(700, 250, 16)); //DR index 5

    partialChoice = new ArrayList<PartialPiece>();
    partial.shuffle();
    for (int i = 0; i < 18; i++) {
      if (i < 9) partialChoice.add(new PartialPiece((i*100)+100, 400, partial.get(i) + ".jpeg"));
      else partialChoice.add(new PartialPiece(((i-9)*100)+100, 500, partial.get(i) + ".jpeg"));
    }
  }

  void drawPuzzle()
  {
    background(205, 210, 212);
    textSize(15);
    text("Replicate the full print in the left 2x6 grid by dragging partial prints from the bottom!", 250, 30);
    //draw reset button
    stroke(0);
    fill(0);
    rect(900, 100, 150, 75);
    fill(255);
    textSize(40);
    text("RESET", 920, 150);

    //draws full print on left
    print.drawPiece();

    //draws right 2x6 box for user to add partials   
    for(int i = 0; i < blankPiece.size(); i++)
    {
      blankPiece.get(i).drawPiece();
    }

    //draws bottom 18x2 box for user selection
    for (int i = 0; i < partialChoice.size(); i++)
    {
      partialChoice.get(i).drawPiece();
    }
    
     for(int x = 0; x < blankPiece.size(); x++) {
      for (int i = 0; i < partialChoice.size(); i++)
      {
        blankPiece.get(x).checkProx(partialChoice.get(i));
        checkCorrect(i);
      }
    }

    if ((UL && UR && ML && MR && DL && DR) == true) {
     completed = true;
     println("win");
    }
  }

  void move() {
    if (mouseX > 900 && mouseX < 1050 && mouseY > 100 && mouseY < 175) {
      for (int i = 0; i < partialChoice.size(); i++) {
        partialChoice.get(i).reset();
      }
      return;
    }
    for (int i = 0; i < partialChoice.size(); i++) {
      partialChoice.get(i).clicked = false;
    }
    for (int i = 0; i < partialChoice.size(); i++) {
      if (partialChoice.get(i).checkMove()) return;
    }
  }

  void draggedPiece() {
    for (int i = 0; i < partialChoice.size(); i++) {
      partialChoice.get(i).dragged();
    }
  } 

  void snapPiece() {
    for(int x = 0; x < blankPiece.size(); x++) {
      for (int i = 0; i < partialChoice.size(); i++)
      {
        blankPiece.get(x).checkSnap(partialChoice.get(i));
      }
    }
  }
  
  void checkCorrect(int i) {
    //println(blankPiece.get(i).contains);
    switch(pos) {
   case 0:
     if (blankPiece.get(0).contains == true && partial.get(i) == 1) {
       println("true");
       UL = true;
     }
     if (blankPiece.get(1).contains == true && partial.get(i) == 2) {
       println("true2");
       UR = true;
     }
     if (blankPiece.get(2).contains == true && partial.get(i) == 3) {
       println("true3");
       ML = true;
     }
     if (blankPiece.get(3).contains == true && partial.get(i) == 4) {
       println("true4");
       MR = true;
     }
     if (blankPiece.get(4).contains == true && partial.get(i) == 5) {
       println("true5");
       DL = true;
     }
     if (blankPiece.get(5).contains == true && partial.get(i) == 6) {
       println("true6");
       DR = true;
     }
      break;
   case 1:
     if (blankPiece.get(0).contains == true && partial.get(i) == 7) {
       println("true");
       UL = true;
     }
     if (blankPiece.get(1).contains == true && partial.get(i) == 8) {
       println("true2");
       UR = true;
     }
     if (blankPiece.get(2).contains == true && partial.get(i) == 9) {
       println("true3");
       ML = true;
     }
     if (blankPiece.get(3).contains == true && partial.get(i) == 10) {
       println("true4");
       MR = true;
     }
     if (blankPiece.get(4).contains == true && partial.get(i) == 11) {
       println("true5");
       DL = true;
     }
     if (blankPiece.get(5).contains == true && partial.get(i) == 12) {
       println("true6");
       DR = true;
     }
     break;
   case 2:
     if (blankPiece.get(0).contains == true && partial.get(i) == 13) {
       println("true");
       UL = true;
     }
     if (blankPiece.get(1).contains == true && partial.get(i) == 14) {
       println("true2");
       UR = true;
     }
     if (blankPiece.get(2).contains == true && partial.get(i) == 15) {
       println("true3");
       ML = true;
     }
     if (blankPiece.get(3).contains == true && partial.get(i) == 16) {
       println("true4");
       MR = true;
     }
     if (blankPiece.get(4).contains == true && partial.get(i) == 17) {
       println("true5");
       DL = true;
     }
     if (blankPiece.get(5).contains == true && partial.get(i) == 18) {
       println("true6");
       DR = true;
     }
     break;
    }
  }
}