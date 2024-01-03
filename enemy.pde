class Enemy extends Player{
  final float MOVEMENT_SPEED = 6;
  PVector position = new PVector(0,0,10);
  PVector originalPos = new PVector(0,0,10);
  int currTime;
  int playerSize=40;
  final float COLLISION_RADIUS = 20;
  
  //ease in ease out variables
  final float MAX_MOVE = 100;
  final float LERP_STEP = 0.01;
  PVector newPos = position.copy();
  float lerpCounter = 1;
  PVector velocity = new PVector(0,0);
  final float MAX_VELOCITY =10;
  PVector directionVector = new PVector(0,0);
  
  //animation variables
  int frameCounter;
  
  int index;
  
  public Enemy(PVector pos){
    this.originalPos = pos.copy();
    this.position = pos.copy();
  }
  
  public Enemy(PVector pos,int index){
    this.originalPos = pos.copy();
    this.position = pos.copy();
    this.index = index;
  }
  
  public void drawEnemy(){
    beginShape();
    vertex(position.x-playerSize,position.y-playerSize,position.z);//bot left
    vertex(position.x-playerSize,position.y+playerSize,position.z);//top left
    vertex(position.x+playerSize,position.y+playerSize,position.z);//top right
    vertex(position.x+playerSize,position.y-playerSize,position.z);//bot right
    endShape();
  }
  
  public void drawAnimated(){
    if(!dead){
      frameCounter= frameCounter%NUM_FRAMES;
      image(enemyFrames[frameCounter],position.x-playerSize,position.y-playerSize);
      frameCounter+=1;
    }
  }
  
  public PVector getVectorToPlayer(){
    PVector playerPos = player.getPos();
    PVector VectorToPlayer = playerPos.sub(position);
    return VectorToPlayer;
  }
  
  public void shootAtPlayer(){
    currTime=millis();
    if(startTime + 1000<currTime){
      enemiesClass.enemyProjectiles[index].shoot(getVectorToPlayer());
      startTime=currTime;
    }
  }
  
  public PVector getPos(){
    return position.copy();
  }
  
  public void moveEnemy(){
    if(lerpCounter >=1){
      newPos = new PVector((position.x+random(-MAX_MOVE,MAX_MOVE)),(position.y+random(-MAX_MOVE,MAX_MOVE)));
      directionVector = PVector.sub(newPos,position).normalize();
      lerpCounter=0;
      velocity.set(0,0);
    }
    if(lerpCounter<0.5){
      velocity.x = lerp(0,(MAX_VELOCITY*directionVector.x),lerpCounter);
      velocity.y = lerp(0,(MAX_VELOCITY*directionVector.y),lerpCounter);
      
    }else{
      velocity.x = lerp(0,(MAX_VELOCITY*directionVector.x),1-lerpCounter);
      velocity.y = lerp(0,(MAX_VELOCITY*directionVector.y),1-lerpCounter);
    }
    float newXPos = position.x+velocity.x;
    float newYPos = position.y+velocity.y;
    position.set(newXPos,newYPos,10);
    lerpCounter+=LERP_STEP;
  }
  
  public void bulletHit(){
    position.set(random(-300,300),random(-300,300),0);
  }
}
