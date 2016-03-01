class Endpoint
{
  int sX, sY, eX, eY;
  Level level;
  Endpoint(int sX, int sY, int eX, int eY, Level level)
  {
    this.sX = sX;
    this.sY = sY;
    this.eX = eX;
    this.eY = eY;
    this.level = level;
  }

  void drawEndpoint()
  {
    fill(255, 0, 0);
    rect(sX, sY, eX, eY);
  }

  boolean levelCompleted(Player player)
  {
    return ((player.hasData == level.dataNeeded) && player.posX > sX && player.posX+30 < eX && player.posY > sY && player.posY+30 < eY);
  }
}