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