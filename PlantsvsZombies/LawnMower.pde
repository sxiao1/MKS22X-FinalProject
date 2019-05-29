class LawnMower extends Character implements Moveable{
  
  boolean active;
  boolean moving;
  
  LawnMower(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage mowImage){
    super(xcor, ycor, wid, len, dam, startHP, mowImage);
    active = true;
    moving = false; 
  }
  
  public void attack(Character other){
    if (other instanceof Zombie){
      other.takeHit(100.0);
    }
  }
  
  public void move(){
    x += 4;
  }
  
  public boolean getActive(){
    return active;
  }
  
  public void setActive(boolean status){
    active = status;
  }
  
  public boolean getMoving(){
    return moving;
  }
  
  public void setMoving(boolean status){
    moving = status;
  }
  
  // check if touching another character 
  boolean isTouching (Character other){
    if (this.getX() >= other.getX() && this.getX() <= other.getX() + other.getW()
    &&  this.getY() + this.getL() == other.getY() + other.getL()){
    return true;
    }
    return false;
  }
  
}
