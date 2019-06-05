// parent class Zombie
abstract class Zombie extends Character implements Damageable, Displayable, Collideable, Moveable{
  float speed;
  float currentSpeed;
  boolean moving;
  float angle;
  float endX;
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and zombie image
  Zombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage zombieImage){
    super(xcor, ycor, wid, len, dam, startHP, zombieImage);
    //speed = speedNum;
    speed = 0; 
    currentSpeed = speedNum;
    moving = true;
    angle = 0; 
    endX = -80; 
  }

  float getSpeed(){
    return speed;
  }
 
  // if Zombie is touching plant, return true; otherwise return false 
  boolean isTouching(Character other){
    if (x >= other.getX() && x <= other.getX() + other.getW()
    &&  y + l == other.getY() + other.getL()){
    return true;
    }
    return false;
  }
  
  boolean isTouching(Zombie other){
    if (other.getY() == getY() &&
        other.getX() >= getX() && other.getX() <= getX() + getW()
         ){
        
    return true; 
     }
     return false;
  }
  
  // check if zombie is touching a pea
  boolean isTouching(Pea other){
    if (other.x >= getX() && other.x <= getX() + w
     && other.y >= getY() && other.y <= getY() + l){
    return true;
    }
    return false;
  }
  
  boolean isTouching(Cherry cherryb){
    if (cherryb.x >= getX() && cherryb.x <= getX() + w
     && cherryb.y >= getY() && cherryb.y <= getY() + l){

    return true;
    }
    return false;
  }
  int die = 0;
  
  void move(){
    // end game if zombies get into the house 
    if (x <= endX){
     lose = true; 
    }
    // while still on screen 
    else if (millis() > 10000 && x > endX){
      // loop through list of collideables
      for (int c = thingsToCollide.size() - 1; c >= 0; c--){
        
         Collideable thing = thingsToCollide.get(c);
         if (thing instanceof Zombie){
           Zombie zomb = (Zombie)thing;
           // change zombie speeds if two are alive and are touching each other 
           if (this != zomb && this.isTouching(zomb) && zomb.getHP() > 0){
             currentSpeed = 0.1;
             zomb.currentSpeed = 2;
           }
           
         }
         else if (thing instanceof LawnMower){
           LawnMower lawnm = (LawnMower)thing;
           
           // zombies trigger lawn mowers when they reach too close to the house 
           if ( lawnm.getMoving() || this.getX() <= 50 && this.getY() + this.getL() == lawnm.getY() + lawnm.getL() && lawnm.getActive()){
             
             if (!lawnm.getMoving()){

               thingsToMove.add(lawnm);
               lawnm.setMoving(true);
             }
                   
             if (lawnm.isTouching(this)){
               lawnm.attack(this);
               currentSpeed = 0;
             }
           }
           
         }
         
         else if (thing instanceof Pea){
           Pea pea = (Pea)thing;
           
           if (this.isTouching(pea) && pea.isActive() && this.getHP() > 0){
            currentSpeed = 0; 
            // pea attacks and is removed
            pea.attack(this);
            pea.setActive(false);
            thingsToDisplay.remove(pea);
            thingsToMove.remove(pea);
            currentSpeed = speed;
           }
         }
         
         //checking if collideable is a cherry
         else if (thing instanceof Cherry){
          Cherry ch = (Cherry)thing;
          if (this.isTouching(ch) && this.getHP() > 0 && ch.getHP() > 0){
            ch.attack(this);
            thingsToDisplay.remove(ch);
            thingsToCollide.remove(ch);
            if(ch.getHP()==0){
              
            int plotR = (int)((ch.getY() - 80) / 100);
            int plotC = (int)(ch.getX() / 78);
            plots[plotR][plotC] = false;
            numPlants[plotR] -= 1;
 
            currentSpeed = speed;
            }
          }
        }
        
        // check if collideable is a plant 
         else if (thing instanceof Plant){
    
          Plant p = (Plant)thing;
          // if zombie is touching plant and both zombie and plant are alive
          if (this.isTouching(p) && p.getHP() > 0 && this.getHP() > 0){
            currentSpeed = 0; 
            // zombie attacks
            attack(p);
            // remove plant from list of displayables if it is dead
           }
            if(p.getHP()==0){
   
            int plotR = (int)((p.getY() - 80) / 100);
            int plotC = (int)(p.getX() / 78);
            plots[plotR][plotC] = false;

            thingsToDisplay.remove((Displayable)p);
            thingsToCollide.remove((Collideable)p);
            currentSpeed = speed;
            }
        }
      }
                    
        // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              moving = false;
              zombieDead.play();
            } 
            
      x -= currentSpeed;
    }
  }
  
  void display(){

    angle = PI/48.0;
    float frame = second() % 4;
    PImage character = getImage();
    // move the zombie image back and forth (animate)
    pushMatrix();
     translate(x,y);
     
     // death rotation
     if (!moving){
       rotate(-90); 
       image(character,0,70, w,l);
       if (frameCount % 5 == 4){
       thingsToDisplay.remove(this);
       thingsToMove.remove(this);
       }
     }
     
     if (frame == 0){
     rotate(angle);
     image(character,0,0, w,l);
     }
     else if (frame == 1 || frame == 3){
     rotate(0);
     image(character,0,0, w,l);
     }
     else if (frame == 2){
     rotate(-angle);
     image(character,0,0, w,l);
     }
    popMatrix(); 

  }
  
}
