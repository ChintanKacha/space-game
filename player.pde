final float TOP_BOUNDARY   = 370;
final float BOTTOM_BOUNDARY=-370;
final float RIGHT_BOUNDARY = 750;
final float LEFT_BOUNDARY  =-750;

class Player{
  final float PLAYER_HEIGHT = 5;
  float playerSize = 40;
  final float COLLISION_RADIUS = 20;
  PVector position = new PVector(0,-300,PLAYER_HEIGHT);
  PVector originalPos = new PVector(0,-300,PLAYER_HEIGHT);
  final float DRIFT_SPEED = 0.6;
  final float MOVEMENT_SPEED = 10;
  int startTime;
  boolean dead=false;
  
  public Player(){
    startTime=millis();
  }
  
  public Player(PVector position){
    this.originalPos = position.copy(); //<>//
    this.position = position.copy();
  }
  
  public void drawPlayer(){
    if(!dead){
      beginShape();
      vertex(position.x-playerSize,position.y-playerSize,position.z);
      vertex(position.x-playerSize,position.y+playerSize,position.z);
      vertex(position.x+playerSize,position.y+playerSize,position.z);
      vertex(position.x+playerSize,position.y-playerSize,position.z);
      endShape();
    }
  }
  
  public void drawSprite(){
    if(!dead){
      image(playerSprite,position.x-playerSize,position.y-playerSize,playerSize*2,playerSize*2);
    }
  }
  
  public PVector getPos(){
    return position.copy();
  }
  
  void moveUp(boolean drift){
    float speed;
    if(drift){
      speed = DRIFT_SPEED;
    }else{
      speed = MOVEMENT_SPEED;
    }
    PMatrix3D translationMatrix = getTranslation(0,speed);
    position = translationMatrix.mult(position,null);
  }
  
  void moveRight(boolean drift){
    float speed;
    if(drift){
      speed = DRIFT_SPEED;
    }else{
      speed = MOVEMENT_SPEED;
    }
    PMatrix3D translationMatrix = getTranslation(speed,0);
    position = translationMatrix.mult(position,null);
  }
  
  void moveDown(boolean drift){
    float speed;
    if(drift){
      speed = DRIFT_SPEED;
    }else{
      speed = MOVEMENT_SPEED;
    }
    PMatrix3D translationMatrix = getTranslation(0,-speed);
    position = translationMatrix.mult(position,null);
  }
  
  void moveLeft(boolean drift){
    float speed;
    if(drift){
      speed = DRIFT_SPEED;
    }else{
      speed = MOVEMENT_SPEED;
    }
    PMatrix3D translationMatrix = getTranslation(-speed,0);
    position = translationMatrix.mult(position,null);
  }
  
  public void bulletHit(){
    dead=true;
  }
  
  public boolean isDead(){
    return dead;
  }
}

void movePlayer(){
  if(!player.isDead()){
    if(moveRight){
      player.moveRight(false);
    }
    if(moveLeft){
      player.moveLeft(false);
    }
    if(moveDown){
      player.moveDown(false);
    }
    if(moveUp){
      player.moveUp(false);
    }
  }
}

void enforcePlayerBoundary(){
  if(player.position.y>TOP_BOUNDARY){
    player.position.y=TOP_BOUNDARY;  
  }
  if(player.position.y<BOTTOM_BOUNDARY){
    player.position.y=BOTTOM_BOUNDARY;  
  }
  if(player.position.x<LEFT_BOUNDARY){
    player.position.x=LEFT_BOUNDARY;
  }
  if(player.position.x>RIGHT_BOUNDARY){
    player.position.x=RIGHT_BOUNDARY;
  }
}

void driftPlayer(){
  if(player.position.y<player.originalPos.y){
    player.moveUp(true);
  }else{
    player.moveDown(true);
  }
  
  if(player.position.x<player.originalPos.x){
    player.moveRight(true);
  }else{
    player.moveLeft(true);
  }
}
