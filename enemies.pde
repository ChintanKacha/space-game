int numEnemies = 1;
int currTime = millis();
final int MAX_ENEMIES = 10;
final int DIFFICULTY_TIMER =10;//seconds before new enemy spawns

class Enemies{
  Enemy[] enemies = new Enemy[MAX_ENEMIES];
  Projectiles[] enemyProjectiles = new Projectiles[MAX_ENEMIES];
  final float COLLISION_RADIUS = 100;
  
  public Enemies(){
    for(int i=0;i<numEnemies;i++){
      enemies[i] = new Enemy(new PVector(random(-300,300),random(-300,300),0),i);
    }
  }
  
  public void initializeProjectiles(){
    for(int i=0;i<numEnemies;i++){
      enemyProjectiles[i]= new Projectiles(enemies[i]);
    }
  }
  
  public void moveEnemies(){
    for(int i=0;i<numEnemies;i++){
      enemies[i].moveEnemy();
    }
  }
  
  public void drawAnimated(){
    for(int i=0;i<numEnemies;i++){
      enemies[i].drawAnimated();
    }
  }
  
  public void drawEnemies(){
    for(int i=0;i<numEnemies;i++){
      enemies[i].drawEnemy();
    }
  }
  
  public void shootAtPlayer(){
    for(int i=0;i<numEnemies;i++){
      enemies[i].shootAtPlayer();
    }
  }
  
  public void checkPruning(){
    for(int i=0;i<numEnemies;i++){
      enemyProjectiles[i].checkPruning();
    }
  }
  
  public void drawProjectiles(){
    for(int i=0;i<numEnemies;i++){
      enemyProjectiles[i].drawProjectiles();
    }
  }
  
  public void moveProjectiles(){
    for(int i=0;i<numEnemies;i++){
      enemyProjectiles[i].moveProjectiles();
    }
  }
  
  public void checkPlayerHit(){
    for(int i=0;i<numEnemies;i++){
      enemyProjectiles[i].checkProjectleHits(player);
    }
  }
  
  public void increaseEnemies(){
    int time = millis();
    if(time - currTime>DIFFICULTY_TIMER*1000){
      addEnemy();
      currTime=time;
    } //<>//
  }
  
  public void addEnemy(){
    if(numEnemies !=MAX_ENEMIES){
      enemies[numEnemies]= new Enemy(new PVector(random(-300,300),random(-300,300),0),numEnemies);
      enemyProjectiles[numEnemies] = new Projectiles(enemies[numEnemies]);
      numEnemies+=1;
    }
  }
  
  public void checkPlayerCollision(){
    if(!player.isDead()){
      PVector distance;
      for(int i=0;i<numEnemies;i++){
        distance = PVector.sub(player.position,enemies[i].position);
        
        if((distance.x*distance.x)+(distance.y*distance.y)<this.COLLISION_RADIUS*this.COLLISION_RADIUS){
          enemies[i].bulletHit(); //<>//
          player.bulletHit();
        }
      }
    }
  }
}
