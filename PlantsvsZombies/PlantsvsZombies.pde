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
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  float getHP(){
    return HP;
  }
  float getDamage(){
    return damage;
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
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  float getHP(){
    return HP;
  }
  float getSpeed(){
    return speed;
  }
  float getDamage(){
    return damage;
  }
}
void setup(){
  size(1024,600);
  PImage background;
  background = loadImage("background.jpg");
  image(background,0,0);
  fill(255);
  rect(70,80,70,70);
}