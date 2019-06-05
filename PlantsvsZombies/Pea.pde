// pea class, shot by the peashooter
class Pea implements Displayable, Moveable, Collideable{
  float x,y,w,l,speed,damage;
  boolean active; // check if pea is still active (has not hit target) 
  
public Pea(float xcor, float ycor, float wid, float len, float speedNum, float dam, boolean active){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    speed = speedNum;
    damage = dam; 
    this.active = active;
  }
  
  public void display(){
    fill(6,214,21); // green color
    ellipse(x, y, w, l); // create the ellipse shape of the pea
  }
  
  // move 
  public void move(){
    x += 3;
  }
  
  // attack zombie
  public void attack(Zombie z){
    if (x < width){
    z.takeHit(damage);
    }
  }
  
  // check if pea and zombie are touching 
  public boolean isTouching(Character other){
    if (x >= other.getX() && x <= other.getX() + other.getW()
     && y >= other.getY() && y <= other.getY() + other.getL()){
    return true;
    }
    return false;
  }
  
  // check if pea is active
  public boolean isActive(){
    return active;
  }
  
  // change the status of the pea
  public void setActive(boolean status){
    active = status;
  }
}
