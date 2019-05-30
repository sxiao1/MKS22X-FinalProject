// parent class Zombie
abstract class Zombie extends Character implements Damageable, Displayable, Collideable, Moveable{
  float speed;
  float currentSpeed;
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and zombie image
  Zombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage zombieImage){
    super(xcor, ycor, wid, len, dam, startHP, zombieImage);
    speed = speedNum;
    currentSpeed = speedNum;
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
  
  boolean isTouching(Pea other){
    if (other.x >= getX() && other.x <= getX() + w
     && other.y >= getY() && other.y <= getY() + l){
       //System.out.println("zombie is touching pea");
    return true;
    }
    return false;
  }
  
  void move(){
    if (x <= 10){
     // runGame = false;
     // System.out.println("end game");
    }
    // while still on screen 
    else if (x > 10){
      // loop through list of collideables

      for (int c = thingsToCollide.size() - 1; c >= 0; c--){
        
         Collideable thing = thingsToCollide.get(c);
         if (thing instanceof LawnMower){
           LawnMower lawnm = (LawnMower)thing;
           if ( this.getX() <= 200 && this.getY() + this.getL() == lawnm.getY() + lawnm.getL() && lawnm.getActive() && this.getHP() > 0){
             
             if (!lawnm.getMoving()){
               System.out.println("add lawn mower to move");  
               thingsToMove.add(lawnm);
               lawnm.setMoving(true);
             }
                   
             if (lawnm.isTouching(this)){
               System.out.println("Lawn attack zombie");
               lawnm.attack(this);
              thingsToDisplay.remove(this);
              thingsToMove.remove(this);
             }
           }
           
         }
         else if (thing instanceof Pea){
           Pea pea = (Pea)thing;
           
           if (this.isTouching(pea) && pea.isActive() && this.getHP() > 0){
            currentSpeed = 0; 
            System.out.println("zombie speed:"+speed);
            // pea attacks and "new" pea is created
            pea.attack(this);
            pea.setActive(false);
            thingsToDisplay.remove(pea);
            thingsToMove.remove(pea);
            currentSpeed = 4;
           }
         }
        // check if collideable is a plant 
         else if (thing instanceof Plant){
    
          Plant p = (Plant)thing;
          //System.out.println("Zombie is touching plant");
          // if zombie is touching plant and both zombie and plant are alive
          if (this.isTouching(p) && p.getHP() > 0 && this.getHP() > 0){
            currentSpeed = 0; 
            // zombie attacks
            attack(p);
            // remove plant from list of displayables if it is dead
           }
            if(p.getHP()==0){
            System.out.println("remove peashooter!");
   
            int plotR = (int)((p.getY() - 80) / 100);
            int plotC = (int)(p.getX() / 78);
            plots[plotR][plotC] = false;
            thingsToDisplay.remove((Collideable)p);
            System.out.println(thingsToDisplay.size());
            currentSpeed = speed;
            }
        }
  
      }
       
        // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              System.out.println("remove zombie!");
              thingsToDisplay.remove(this);
              thingsToMove.remove(this);
            }          
      x -= currentSpeed;
    }
  }
}
