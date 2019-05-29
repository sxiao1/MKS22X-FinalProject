// parent Plant class
abstract class Plant extends Character{
  
  // takes in x - and y-coordinates, width, length, damage points, starting HP, and plant image
  Plant(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage plantImage){
    super(xcor,ycor,wid,len,dam,startHP,plantImage);
  }
  
  // return true if zombie coordinates overlap with current plant, otherwise return false
   boolean isTouching(Character other){
     if (other.x >= getX() && other.x <= getX() + w
    &&  other.getY() + other.l == getY() + l){
    return true;
    }
    return false;
  }
  
  // if being attacked by a zombie, reduce HP
  void takeHit(float dam){
    this.HP -= dam;
  }
 
}
