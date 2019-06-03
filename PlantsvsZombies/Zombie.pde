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
    endX = 10 + (int)(Math.random() * 75); 
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
           System.out.println("this zombie's coordinates: "+this.getX() +", "+this.getY());
           System.out.println("other zombie's coordinates: "+other.getX() +", "+other.getY());
        
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
    else if (x > endX){
      // loop through list of collideables
      int subbed = 0; // number of times plant has been subtracted
      for (int c = thingsToCollide.size() - 1; c >= 0; c--){
        
         Collideable thing = thingsToCollide.get(c);
         if (thing instanceof Zombie){
           Zombie zomb = (Zombie)thing;
           if (this != zomb && this.isTouching(zomb)){
             System.out.println("zombies are touching");
             rect(x,y, 50, 50);
             currentSpeed = 0.1;
             zomb.currentSpeed = 2;
           }
           
         }
         else if (thing instanceof LawnMower){
           LawnMower lawnm = (LawnMower)thing;
           if ( lawnm.getMoving() || this.getX() <= 200 && this.getY() + this.getL() == lawnm.getY() + lawnm.getL() && lawnm.getActive()){
             
             if (!lawnm.getMoving()){
               System.out.println("add lawn mower to move");  
               thingsToMove.add(lawnm);
               lawnm.setMoving(true);
             }
                   
             if (lawnm.isTouching(this)){
               System.out.println("Lawn attack zombie");
               lawnm.attack(this);
               currentSpeed = 0;
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
            currentSpeed = speed;
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
          //  if (subbed == 0){
              numPlants[plotR] -= 1;
              lanes.get(plotR).setNum( numPlants[plotR] ); 
           //   subbed = 1;
           // }
            System.out.println("number of plants in row" + plotR+": "+numPlants[plotR]);
            thingsToDisplay.remove((Displayable)p);
            thingsToCollide.remove((Collideable)p);
            System.out.println(thingsToDisplay.size());
            currentSpeed = speed;
            }
        }
       // x -= currentSpeed;
      }
                    
        // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              System.out.println("remove zombie!");
              moving = false;
            } 
            
      x -= currentSpeed;
    }
  }
  
  void display(){

    angle = PI/48.0;
    float frame = second() % 4;
    PImage character = getImage();
    pushMatrix();//backup the original coordinate system
    //Change the coordinates for 
    //all objects then draw everything.
    //Draw all the things you want to draw
    //change the coordinates for JUST this one object
     translate(x,y);
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
    popMatrix(); //restore the original coordinate system

  }
  
}
