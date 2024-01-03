class Projectiles{
  final float PRUNE_DISTANCE_Y = 1000;
  final float PRUNE_DISTANCE_X = 1000;
  final int MAX_PROJECTILES = 20;
  
  Player player;
  Projectile[] projectiles = new Projectile[MAX_PROJECTILES];
  int numProjectiles =0;
  
  public Projectiles(Player player){
    this.player=player;
  }
  
  public void shoot(){
    projectiles[numProjectiles] = new Projectile(player.getPos());
    projectiles[numProjectiles].setProjectiles(this);
    numProjectiles+=1;
  }
  public void shoot(PVector direction){
    direction.normalize();
    projectiles[numProjectiles] = new Projectile(this.player.getPos(),direction);
    projectiles[numProjectiles].setProjectiles(this);
    numProjectiles+=1;
  }
  
  public void drawProjectiles(){
    for(int i=0;i<numProjectiles;i++){
      projectiles[i].drawProjectile();
    }
  }
  
  public void moveProjectiles(){
    for(int i=0;i<numProjectiles;i++){
      projectiles[i].moveProjectile();
    }
  }
  
  public void checkPruning(){
    for(int i=0;i<numProjectiles;i++){
      if(projectiles[i].getYCord()>PRUNE_DISTANCE_Y || 
         projectiles[i].getYCord()<-PRUNE_DISTANCE_Y||
         projectiles[i].getXCord()>PRUNE_DISTANCE_X ||
         projectiles[i].getYCord()<-PRUNE_DISTANCE_X){
        pruneProjectile(i);
      }
    }
  }
  
  public void pruneProjectile(int index){
    projectiles[index]=null;
    if(index<numProjectiles-1){
      for(int i=index;i<numProjectiles-1;i++){
        projectiles[i] = projectiles[i+1];
      }
    }
    numProjectiles-=1;
  }
  
  public int getLength(){
    return projectiles.length;
  }
  
  public void checkProjectleHits(Player entity){
    for(int i=0;i<numProjectiles;i++){
      if(projectiles[i].checkHit(entity)){
        pruneProjectile(i);
        entity.bulletHit();
      }
    }
  }
  
}

class Projectile{
  final float PROJECTILE_SPEED = 10;
  final float PROJECTILE_SIZE =  5;
  final float PROJECTILE_DEPTH = 10;
  PVector position;
  PVector forward;
  Projectiles projectiles;
  
  final float COLLISION_RADIUS = 50;
  
  //player projectiles that move up
  public Projectile(PVector pos){
    this.position=pos.copy();
    forward = new PVector(0,1,0);
  }
  
  public Projectile(PVector pos,PVector forward){
    this.position=pos.copy();
    this.forward = forward.copy();
  }
  
  public void setProjectiles(Projectiles projectiles){
    this.projectiles=projectiles;
  }
  
  public void moveProjectile(){
    //PMatrix3D translationMatrix = getTranslation(0,PROJECTILE_SPEED);
    PMatrix3D translationMatrix = getTranslation((forward.x*PROJECTILE_SPEED),(forward.y*PROJECTILE_SPEED));
    position = translationMatrix.mult(position,null);
  }
  
  public void drawProjectile(){
    beginShape();
    vertex((position.x-PROJECTILE_SIZE),(position.y+PROJECTILE_SIZE),PROJECTILE_DEPTH);
    vertex((position.x+PROJECTILE_SIZE),(position.y+PROJECTILE_SIZE),PROJECTILE_DEPTH);
    vertex((position.x+PROJECTILE_SIZE),(position.y-PROJECTILE_SIZE),PROJECTILE_DEPTH);
    vertex((position.x-PROJECTILE_SIZE),(position.y-PROJECTILE_SIZE),PROJECTILE_DEPTH);
    endShape();
  }
  
  public float getYCord(){
    return position.y;
  }
  
  public float getXCord(){
    return position.x;
  }
  public boolean checkHit(Player entity){
    boolean hit=false;
    PVector entityPos = entity.getPos();
    PVector distance = PVector.sub(position,entityPos);
    if((distance.x*distance.x)+(distance.y*distance.y)<this.COLLISION_RADIUS*this.COLLISION_RADIUS){
      hit = true;
    }
    return hit;
  }
}
