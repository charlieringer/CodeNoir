class StatusBar
{
  void drawStatusBar(String status)
  {
    fill(0);
    rect(0, 600, width, 620);
    fill(255);
    text(status, 100, 610);
  }
}