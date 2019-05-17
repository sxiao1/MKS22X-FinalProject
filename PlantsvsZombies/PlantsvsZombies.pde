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

interface Collideable{
  boolean isTouching(Plant other);
  boolean isTouching(Zombie other);
}

abstract class Plant implements Damageable, Displayable, Collideable{
  float x,y, w,l, damage,HP;
  PImage plant;
  
  Plant(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage plantImage){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    damage = dam;
    HP= startHP;
    plant = plantImage;
  }
  
  void display(){
    image(plant,x,y, w,l);
  }
  boolean isTouching(Plant other){
    return false;
  }
  
   boolean isTouching(Zombie other){
     if (other.x >= getX() && other.x <= getX() + w
    &&  other.getY() + other.l == getY() + l){
    return true;
    }
    return false;
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
  Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, wid, len, dam, startHP, peashooter);
    this.rate = rate;
  }

  void attack(){
    
  }
  
  void display(){
    super.display();
  }
  boolean isTouching(){
    return false;
  }
}

class Sunflower extends Plant{
  float rate; 
  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
    super(xcor, ycor, wid, len, dam, startHP, sunflower);
    this.rate = rate;
  }
  
  // sunflower has no offensive ability 
  void attack(){  
  }
  
  void display(){
    super.display();
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

abstract class Zombie implements Damageable, Displayable, Collideable{
  float HP,x,y,w,l,speed, damage;
  PImage zombie;
  Zombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage zombieImage){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    speed = speedNum;
    damage = dam;
    HP = startHP;
    zombie = zombieImage;
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
  
  boolean isTouching(Zombie other){
    return false;
    
  }
  boolean isTouching(Plant other){
    if (x >= other.getX() && x <= other.getX() + other.w
    &&  y + l == other.getY() + other.l){
    return true;
    }
    return false;
  }
  void display(){
    
    image(zombie, x,y,w,l);
  }
}

class BasicZombie extends Zombie implements Moveable{
  BasicZombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage basicZombie){
    super(xcor, ycor, wid, len, speedNum, dam, startHP, basicZombie);
  }
  
  void attack(){
  }
  
  void move(){
    if (x > 0){
      x -= speed;
      for (Collideable thing : thingsToCollide){
        
        if (thing instanceof Plant){
          Plant p = (Plant)thing;
           System.out.println("Found a plant in the list");
          if (this.isTouching(p)){
            System.out.println("Zombie is touching plant");
            attack();
          }
        }
      }
    }
    // System.out.println("x: "+x);
  }

}

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();

PImage background,peashooter,zombie,sunflower,sun;

void setup(){
  size(1024,600);
  background = loadImage("background.jpg");
  
  fill(255);
  rect(70,80,70,70); //size 70x70
  rect(70,80+100,70,70);//space between plots is 20
  
  peashooter = loadImage("peashooter.png");
  image(peashooter,70,80, 80,80);
  Peashooter pea = new Peashooter(70.0,280.0, 80, 80, 10.0,100.0,5.0, peashooter);
  thingsToDisplay.add(pea);
  thingsToCollide.add(pea);
  pea.display();
  
  zombie = loadImage("zombie.png");
  image(zombie,900,80, 80,120);
  BasicZombie zomb = new BasicZombie(900.0,240.0, 80.0, 120.0, 1.0, 1.0, 100, zombie);
  thingsToMove.add(zomb);
  thingsToDisplay.add(zomb);
  zomb.display();
  
  sunflower = loadImage("sunflower.png");
  image(sunflower,70,170,85,100);
  Sunflower sunf = new Sunflower(70.0,360.0, 85, 100, 10.0,100.0,5.0, sunflower);
  thingsToDisplay.add(sunf);
  sunf.display();
  
  sun = loadImage("sun.png");
  image(sun,90,170,50,50);
  
  draw();
}

void draw(){
    image(background,0,0);
  for (Displayable thing: thingsToDisplay){
    thing.display();
  }
  for (Moveable thing : thingsToMove){
    thing.move();
  }
}
