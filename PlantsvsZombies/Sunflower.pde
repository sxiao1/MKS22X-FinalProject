
// Sunflower subclass of Plant
class Sunflower extends Plant{
  float rate; // rate of attack 
  PImage sunImage = loadImage("sun.png");
  
  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Sunflower image
  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
    super(xcor, ycor, wid, len, dam, startHP, sunflower);
    this.rate = rate;
  }
  
  // sunflower has no offensive ability 
  void attack(Character c){  
  }
  
  void display(){
    super.display();
    // produce a new sun every few seconds
    if (millis() > 1000 && frameCount % 300 == 0){
      System.out.println("5 seconds have passed");
      produce();
    }
  }
  
  // instantiate a new sun from the sunflower's coordinates
  void produce(){
    Sun sun = new Sun(this.getX(), this.getY(), this.getL(), 1.0, sunImage);
    System.out.println("add sun");
    thingsToDisplay.add(sun);
    thingsToMove.add(sun);
    listOfSuns.add(sun);
  }
}
