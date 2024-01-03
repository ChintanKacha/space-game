float top = -200;
float bottom = 200;
float left = -400;
float right = 400;
float near = 100;
float far = 0;

Player player;
Projectiles playerProjectiles;
//Projectiles enemyProjectiles;
//Projectiles[] enemyProjectiles;
Enemies enemiesClass;

PImage playerSprite;

void setup() {
  size(1100, 600, P3D); // change the dimensions if desired
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // use normalized 0..1 texture coords
  textureWrap(REPEAT);
  resetMatrix(); // replace this with your chosen camera settings
  
  // do any additional setup here
  initializeBackground();
  player  = new Player();
  
  enemiesClass = new Enemies();
  
  playerProjectiles = new Projectiles(player);
  enemiesClass.initializeProjectiles();
  
  setUpEnemyAnimation();
  playerSprite = loadImage("playerSprite.png");
}

void draw() {
  PVector cameraPos = new PVector(0,0,200);
  PVector cameraCentre = new PVector(0,0,0);
  
  camera(cameraPos.x,cameraPos.y,cameraPos.z,cameraCentre.x,cameraCentre.y,cameraCentre.z,0,1,0);
  frustum(left,right,bottom,top,near,far);
  
  drawBackground();
  
  movePlayer();
  enemiesClass.moveEnemies();
  
  
  enforcePlayerBoundary();
  driftPlayer();
  
  if(doTextures){
    player.drawSprite();
    enemiesClass.drawAnimated();
  }else{
    player.drawPlayer();
    enemiesClass.drawEnemies();
  }
  
  enemiesClass.shootAtPlayer();
  enemiesClass.checkPruning();
  playerProjectiles.checkPruning();
  
  if(doCollision){
    for(int i=0;i<numEnemies;i++){ //check if any player bullets hit an enemy
      playerProjectiles.checkProjectleHits(enemiesClass.enemies[i]);
    }
    enemiesClass.checkPlayerHit();//checks if any enemybullets hit the player
    enemiesClass.checkPlayerCollision();//checks if any enemies are touching the player
  }
  playerProjectiles.drawProjectiles();
  enemiesClass.drawProjectiles();
  
  playerProjectiles.moveProjectiles();
  enemiesClass.moveProjectiles();
  
  enemiesClass.increaseEnemies();
}
