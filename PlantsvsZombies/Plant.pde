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
 
   void display(){
    PImage character = getImage(); 
    float angle = PI/256.0;
    float frame = second() % 4;
    // move the plants back and forth slightly (swaying)
    pushMatrix();
     translate(x,y);
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
