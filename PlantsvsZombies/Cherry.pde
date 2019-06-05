class Cherry extends Plant{
  Cherry(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage cherry){
  super(xcor, ycor, wid, len, dam, startHP, cherry);
  }
  void attack(Character zombie){
    zombie.takeHit(zombie.getHP());
  }
  void display(){
    super.display();
  }
}
  
