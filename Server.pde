class Server
{
  int sX, sY, eX, eY;
  Server(int sX, int sY, int eX, int eY)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
  }
  
  void drawOnLevel()
  {
    fill(0,255,0);
    rectMode(CORNERS);
    rect(sX, sY, eX, eY);
  }
  
  
}