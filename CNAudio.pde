class CNAudio
{
  AudioPlayer [] sound = new AudioPlayer[3];// audioplayer array
  int count = int(random(0,3));// counter for array files


  CNAudio(Minim minim)
  {
    sound[0] = minim.loadFile("data/Audio/back1.mp3");    // load files into array
    sound[1] = minim.loadFile("data/Audio/back2.mp3"); 
    sound[2] = minim.loadFile("data/Audio/back3.mp3"); 
    sound[count].play();
  }

  void playAudio()
  {
    //return early if sound is off.
    if (save.bgMusic == 0)
    {
      sound[count].pause();
      return;
    }
    if (!sound[count].isPlaying())// if it isnt playing
    {
      sound[count].rewind();
      count++; //increment and play
      if (count>=sound.length)
      {
        count=0;//if count >= array index 5 reset to 0 and play from begining
      }
      sound[count].play();
    }
  }
}