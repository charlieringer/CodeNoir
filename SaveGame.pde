import java.io.*;
import java.util.*;

class SaveGame
{
  byte level;
  byte bgMusic;
  byte sfx;

  SaveGame()
  {
    File file = new File(sketchPath("save.dat"));
    if (file.exists())
    {
      byte[] data = loadBytes("save.dat");
      level = data[0];
      bgMusic = data[1];
      sfx = data[2];
    } else {
      level = 1;
      bgMusic = 1;
      sfx = 1;
    }
  }

  void outputSave()
  {
    byte[] output = new byte[3];
    output[0] = level;
    output[1] = bgMusic;
    output[2] = sfx;
    saveBytes("save.dat", output);
  }
}