// player character
final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';
final char KEY_RESET = 'r';

// turn textures or collisions on/off - useful for testing and debugging
final char KEY_TEXTURE = 't';
final char KEY_COLLISION = 'c';

boolean doTextures = false;
boolean doCollision = false;

boolean moveLeft =  false;
boolean moveRight = false;
boolean moveUp =    false;
boolean moveDown =  false;

void keyPressed() {
  
  switch(key){
    case KEY_RIGHT:moveRight=true;
    break;
    case KEY_LEFT :moveLeft =true;
    break;
    case KEY_UP   :moveUp   =true;
    break;   
    case KEY_DOWN :moveDown =true;
    break;
    case KEY_TEXTURE: doTextures=!doTextures;
    break;
    case KEY_COLLISION: doCollision=!doCollision;
    break;
    case KEY_RESET: player.dead = false;
  }
  if(key == KEY_SHOOT){
    if(!player.isDead()){
      playerProjectiles.shoot();
    }
  }
}

void keyReleased() {
  switch(key){
    case KEY_RIGHT:moveRight=false;
    break;
    case KEY_LEFT :moveLeft =false;
    break;
    case KEY_UP   :moveUp   =false;
    break;
    case KEY_DOWN :moveDown =false;
  }
}

PMatrix3D getTranslation(float x,float y){
  return new PMatrix3D(1,0,0,x,
                       0,1,0,y,
                       0,0,1,0,
                       0,0,0,1);
}
