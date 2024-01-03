final int STAR_NUM = 100;
final int STAR_SIZE = 15;
float[] yCord = new float[STAR_NUM];
float[] xCord = new float[STAR_NUM];
float zCord =1;

void drawBackground(){
  stroke(1);
  fill(0);
  beginShape();
  vertex(-width,-height,zCord);
  vertex(width,-height,zCord);
  vertex(width,height,zCord);
  vertex(-width,height,zCord);
  endShape();
  
  for(int i=0;i<STAR_NUM;i++){
    fill(1);
    noStroke();
    beginShape();
    vertex(xCord[i]-(STAR_SIZE/2),yCord[i],zCord);
    vertex(xCord[i],yCord[i]+(STAR_SIZE/2),zCord);
    vertex(xCord[i]+(STAR_SIZE/2),yCord[i],zCord);
    vertex(xCord[i],yCord[i]-(STAR_SIZE/2),zCord);
    endShape();
  }
}

void initializeBackground(){
  for(int i=0;i<STAR_NUM;i++){
    //yCord[i] = random(-width,width);
    //xCord[i] = random(-height,height);
    yCord[i] = random(LEFT_BOUNDARY,RIGHT_BOUNDARY);
    xCord[i] = random(-height,height);
  }
}
