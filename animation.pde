final int FRAME_RATE=60;
final int NUM_FRAMES= 10;
PImage[] enemyFrames = new PImage[NUM_FRAMES];

void setUpEnemyAnimation(){
  for(int i=0;i<enemyFrames.length;i++){
    enemyFrames[i] = loadImage("cloudMove"+i+".png");
  }
}
