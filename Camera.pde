//Ingame security camera
//Constructor: Takes 4 sets of XY coords, the first 3 are the points of the triangle for the camera light. The last point is where the camera is
//drawCamera: Takes no params and draws the camera to the screen.
//checkForPlayer: Takes a player and returns true if the player is inside of the cameras view

class SecurityCamera
{
  PVector pointA;
  PVector pointB;
  PVector pointC;
  int camLocX, camLocY;
  PImage onImage;
  PImage offImage;
  boolean on = true;

  SecurityCamera(int pointXA, int pointYA, int pointXB, int pointYB, int pointXC, int pointYC, int camLocX, int camLocY, int rotate)
  {
    pointA = new PVector(pointXA, pointYA);
    pointB = new PVector(pointXB, pointYB);
    pointC = new PVector(pointXC, pointYC);
    this.camLocX = camLocX;
    this.camLocY = camLocY;
    onImage = loadImage("Art_Assets/In_Game/Levels/Camera/CameraOn"+rotate+".png");
    offImage = loadImage("Art_Assets/In_Game/Levels/Camera/CameraOff"+rotate+".png");
  }

  public void drawCamera()
  {
    if (on)
    {
      fill(255, 255, 0, 75);
      triangle(pointA.x, pointA.y, pointB.x, pointB.y, pointC.x, pointC.y);
      image(onImage, camLocX-10, camLocY-5);
    } else {
      image(offImage, camLocX-10, camLocY-5);
    }

  }

  public boolean checkForPlayer(Player player)
  {
    if (on)
    {
      int playerX = player.posX+15;
      int playerY = player.posY+15;
      return PointInTriangle(new PVector(playerX, playerY), new PVector(pointA.x, pointA.y), new PVector(pointB.x, pointB.y), new PVector(pointC.x, pointC.y) );
    }
    return false;
  }

  //http://stackoverflow.com/questions/2049582/how-to-determine-a-point-in-a-triangle
  private float sign (PVector p1, PVector p2, PVector p3)
  {
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
  }

  private boolean PointInTriangle (PVector pt, PVector v1, PVector v2, PVector v3)
  {
    boolean b1, b2, b3;

    b1 = sign(pt, v1, v2) < 0.0f;
    b2 = sign(pt, v2, v3) < 0.0f;
    b3 = sign(pt, v3, v1) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
  }
}