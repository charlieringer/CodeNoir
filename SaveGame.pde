import java.io.*;
import java.util.*;

class SaveGame
{
  byte level;
  byte bgMusic;

  SaveGame()
  {
    File file = new File(sketchPath("save.dat"));
    if (file.exists())
    {
      byte[] data = loadBytes("save.dat");
      level = data[0];
      bgMusic = data[1];
    } else {
      level = 1;
      bgMusic = 1;
    }
  }

  void outputSave()
  {
    byte[] output = new byte[3];
    output[0] = level;
    output[1] = bgMusic;
    saveBytes("save.dat", output);
  }
  
  void updateLevel(int newLevel)
  {
    if (level < newLevel) level = (byte)newLevel;
  }
}