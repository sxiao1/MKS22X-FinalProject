interface Damageable{
  void takeHit(float HP);
  void die();
}
abstract class Plant implements Damageable{
  float x,y, damage,HP;
  Plant(float xcor, float ycor, float dam, float startHP){
    x = xcor;
    y = ycor;
    damage = dam;
    HP= startHP;
  }
}
abstract class Zombie implements Damageable{
  float HP,x,y,speed, damage;
  Zombie(float xcor, float ycor, float speedNum, float dam){
    x = xcor;
    y = ycor;
    speed = speedNum;
    damage = dam;
  }
}
void setup(){
  
}