class Button {
  PFont cyber;
  int rectX, rectY, textX, textY;
  String title;
  Boolean hover = false;
  
  Button(String title, int rectX, int rectY, int textX, int textY) {
    this.rectX = rectX;
    this.rectY = rectY;
    this.textX = textX;
    this.textY = textY;
    this.title = title;
    
    cyber = createFont("Fonts/renegado.ttf", 30);
  }
  
  void drawButton() {
    if(hover == true) {
      //button outline
      fill(255);
      rect(rectX, rectY, 300, 50);
      
      //button text
      textFont(cyber);
      fill(0);
      text(title, textX, textY);
    } else {
      //button outline
      fill(0);
      rect(rectX, rectY, 300, 50);
    
      //button text
      textFont(cyber);
      fill(255);
      text(title, textX, textY);
    }
  }
  
  void checkHover() {
    if(mouseX > rectX && mouseX < rectX + 300 && mouseY > rectY && mouseY < rectY + 50) {
      hover = true;
    } else {
      hover = false;
    }
  }
  
}