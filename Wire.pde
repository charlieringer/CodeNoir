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
  
  void powered() {
    
     if(forward == true) {
      if (w > 10) {
          rect(startX, startY+2, hor_power, 4);
          hor_power+=2;
          
          if (hor_power >= w)
          {
              hor_power = w;
          }
      } else {
          rect(startX+2, startY, 4, vert_power);
          vert_power+=2;
          
          if (vert_power >= h)
          {
              vert_power = h;
          }
      }  
    } else {
            if (w > 10) {
      rect(startX+w, startY+2, hor_power, 4);
      hor_power-=2;
      if (hor_power <= -(w))
      {
        hor_power = -(w);
      }
    } else {
      rect(startX+2, startY+h, 4, vert_power);
      vert_power-=2;
      if (vert_power <= -(h))
      {
        vert_power = -(h);
      }
    }
   }
   
  }
 }