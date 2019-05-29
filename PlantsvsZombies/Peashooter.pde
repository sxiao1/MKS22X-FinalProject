// Peashooter subclass of Plant
class Peashooter extends Plant{
  float rate; // rate of attack 

  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Peashooter image
  Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, wid, len, dam, startHP, peashooter);
    this.rate = rate;
  }
  
  // produce a pea to shoot
  void produce(){
    Pea myPea = new Pea(super.getX() + super.getW(), super.getY() + 20, 30.0, 30.0, 3.0, 25.0, true);
    thingsToDisplay.add(myPea);
    thingsToMove.add(myPea);
    thingsToCollide.add(myPea);
    listOfPeas.add(myPea); 
  }
  
  // make zombie take hit by damage points
  void attack(Character zombie){
      zombie.takeHit(super.damage);
      System.out.println(zombie.getHP());
  }
  
  void display(){
    super.display();
    
    // shoot pea every few seconds
    if (millis() > 1000 && frameCount % 180 == 0){
      System.out.println(frameCount);
      System.out.println("shoot pea");
      produce();
    }
  }
 
}
