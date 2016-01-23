class Endpoint
{
  int sX, sY, eX, eY;

  Endpoint(int sX, int sY, int eX, int eY)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
  }

  void drawEndpoint()
  {
    fill(255, 0, 0);
    rect(sX, sY, eX, eY);
  }

  boolean levelCompleted(Player player)
  {
    return ((player.hasData) && player.posX > sX && player.posX+30 < eX && player.posY > sY && player.posY+30 < eY);
  }
}