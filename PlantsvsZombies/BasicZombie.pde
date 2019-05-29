
// BasicZombie subclass of Zombie, can move
class BasicZombie extends Zombie{
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and basicZombie image
  BasicZombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage basicZombie){
    super(xcor, ycor, wid, len, speedNum, dam, startHP, basicZombie);
  }
  
  // attack plant if touching 
  void attack(Character p){
    p.takeHit(damage);
   System.out.println(p.getHP());
  }

}
