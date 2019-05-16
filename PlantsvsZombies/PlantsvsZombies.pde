interface Damageable{
  void takeHit(float HP);
  void die();
}

interface Moveable{
  void move();
}


interface Displayable{
  void display();
}

abstract class Plant implements Damageable{
  float x,y, damage,HP;
  PImage plant;
  
  Plant(float xcor, float ycor, float dam, float startHP, PImage plantImage){
    x = xcor;
    y = ycor;
    damage = dam;
    HP= startHP;
    plant = plantImage;
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
  
  void takeHit(float HP){
  }
  
  void die(){
  }
  
  abstract void attack();
}

class Peashooter extends Plant{
  float rate;
  Peashooter(float xcor, float ycor, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, dam, startHP, peashooter);
    this.rate = rate;
  }

  void attack(){
    
  }
  
  boolean isTouching(){
    return false;
  }
}

class Sunflower extends Plant{
  float rate; 
  Sunflower(float xcor, float ycor, float dam, float startHP, float rate){
    super(xcor, ycor, dam, startHP);
    this.rate = rate;
  }
  
  // sunflower has no offensive ability 
  void attack(){  
  }
  
  void produce(){
    Sun sun = new Sun(this.x, this.y, 1);
    sun.move();
  }
  
  boolean isTouching(){
    return false;
  }
}

class Sun implements Moveable{
  float x,y,speed;
  Sun(float xcor, float ycor, float sunSpeed){
    x = xcor;
    y = ycor;
    speed = sunSpeed;
  }
  
  void move(){
    y += speed; 
  }
  
  boolean collected(){
    if (mousePressed && mouseX == x && mouseY == y){
    return true;
    }
    return false;
  }
  
}

abstract class Zombie implements Damageable{
  float HP,x,y,speed, damage;
  Zombie(float xcor, float ycor, float speedNum, float dam, float startHP){
    x = xcor;
    y = ycor;
    speed = speedNum;
    damage = dam;
    HP = startHP;
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
  
  void takeHit(float HP){
  }
  
  void die(){
  }
  
  abstract void attack();
}

class BasicZombie extends Zombie implements Moveable{
  BasicZombie(float xcor, float ycor, float speedNum, float dam, float startHP){
    super(xcor, ycor, speedNum, dam, startHP);
  }
  
  void attack(){
  }
  
  void move(){
  }
}

void setup(){
  size(1024,600);
  
  PImage background,peashooter,zombie,sunflower,sun;
  background = loadImage("background.jpg");
  image(background,0,0);
  fill(255);
  rect(70,80,70,70); //size 70x70
  rect(70,80+100,70,70);//space between plots is 20
  
  peashooter = loadImage("peashooter.png");
  image(peashooter,70,80, 80,80);
  // Peashooter pea = new Peashooter(70.0,80.0,10.0,100.0,5.0); 
  
  zombie = loadImage("zombie.png");
  image(zombie,900,80, 80,120);
  
  sunflower = loadImage("sunflower.png");
  image(sunflower,70,170,85,100);
  
  sun = loadImage("sun.png");
  image(sun,90,170,50,50);
}
