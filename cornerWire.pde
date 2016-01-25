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
  
  