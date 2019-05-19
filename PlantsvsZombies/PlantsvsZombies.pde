// Plant, Zombie implement this 
interface Damageable{
  void takeHit(float damage); // reduce HP by damage amount 
}

// Plant, Zombie, Sun implement this
interface Moveable{
  void move();
}

// all objects implement this
interface Displayable{
  void display();
}

// Plant and Zombie implement this
interface Collideable{
  boolean isTouching(Plant other);
  boolean isTouching(Zombie other);
}

// parent Plant class
abstract class Plant implements Damageable, Displayable, Collideable{
  float x,y, w,l, damage,HP;
  PImage plant;
  
  // takes in x - and y-coordinate, width, length, damage points, starting HP, and plant image
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
  
  // return false -- not applicable to plants
  boolean isTouching(Plant other){
    return false;
  }
  
  // return true if zombie coordinates overlap with current plant, otherwise return false
   boolean isTouching(Zombie other){
     if (other.x >= getX() && other.x <= getX() + w
    &&  other.getY() + other.l == getY() + l){
    return true;
    }
    return false;
  }
  
  // accessor methods
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
  
  // if being attacked by a zombie, reduce HP
  void takeHit(float dam){
    this.HP -= dam;
  }
  
  // attack method to be coded in subclasses
  abstract void attack(Zombie z);
  
 
}

// Peashooter subclass of Plant
class Peashooter extends Plant{
  float rate; // rate of attack 
  
  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Peashooter image
  Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, wid, len, dam, startHP, peashooter);
    this.rate = rate;
  }

  // make zombie take hit by damage points
  void attack(Zombie zombie){
      zombie.takeHit(super.damage);
      System.out.println(zombie.getHP());
  }
  
  void display(){
    super.display();
  }
 
}

// Sunflower subclass of Plant
class Sunflower extends Plant{
  float rate; // rate of attack 
  
  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Sunflower image
  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
    super(xcor, ycor, wid, len, dam, startHP, sunflower);
    this.rate = rate;
  }
  
  // sunflower has no offensive ability 
  void attack(Zombie z){  
  }
  
  void display(){
    super.display();
  }
  
  // instantiate a new sun from the sunflower's coordinates
  void produce(){
    Sun sun = new Sun(this.x, this.y, 1);
    sun.move();
  }
}

// Sun class, for the Sunflower class and also randomly generated suns
class Sun implements Moveable{
  float x,y,speed;
  // takes in x- and y-coordinates and speed of movement 
  Sun(float xcor, float ycor, float sunSpeed){
    x = xcor;
    y = ycor;
    speed = sunSpeed;
  }
  
  void move(){
    y += speed; 
  }
  
  // if the user clicks on the sun, then it has been collected 
  boolean collected(){
    if (mousePressed && mouseX == x && mouseY == y){
    return true;
    }
    return false;
  }
  
}

// parent class Zombie
abstract class Zombie implements Damageable, Displayable, Collideable{
  float HP,x,y,w,l,speed, damage;
  PImage zombie;
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and zombie image
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
  
  // accessor methods
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
  
  // reduce HP by damage points if attacked
  void takeHit(float dam){
    HP -= dam;
  }
  
  // to be completed in subclasses
  abstract void attack(Plant p);
  
  // check if touching Zombie
  boolean isTouching(Zombie other){
    return false;
    
  }
  
  // if Zombie is touching plant, return true; otherwise return false 
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

// BasicZombie subclass of Zombie, can move
class BasicZombie extends Zombie implements Moveable{
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and basicZombie image
  BasicZombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage basicZombie){
    super(xcor, ycor, wid, len, speedNum, dam, startHP, basicZombie);
  }
  
  // attack plant if touching 
  void attack(Plant p){
    p.takeHit(damage);
   System.out.println(p.getHP());
  
  }
  
  void move(){
    // while still on screen 
    if (x > 0){
      // loop through list of collideables
      int i = 0;
      for (Collideable thing : thingsToCollide){
        // check if collideable is a plant 
        if (thing instanceof Plant){
        
          Plant p = (Plant)thingsToCollide.get(i);
          // if zombie is touching plant and both zombie and plant are alive
          if (this.isTouching(p) && p.getHP() > 0 && this.getHP() > 0){
            // both plant and zombie attack each other 
            System.out.println("Zombie is touching plant");
            attack(p);
            p.attack(this);
            // remove plant from list of displayables if it is dead
            if(p.getHP()==0){
            System.out.println("remove peashooter!");
            thingsToDisplay.remove(i);
            System.out.println(thingsToDisplay.size());
            }
            // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              System.out.println("remove zombie!");
              thingsToDisplay.remove(this);
              thingsToMove.remove(this);
              System.out.println("display:"+thingsToDisplay.size());
              System.out.println("move:"+thingsToMove.size());
            }
            }
          
          else{
            x-=speed;
          }
        }
        i++;
      }
    }
  }

}

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();

PImage background,peashooter,zombie,sunflower,sun;

void setup(){
  // load background, plants, zombies, and suns
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
  BasicZombie zomb = new BasicZombie(100.0,240.0, 80.0, 120.0, 0.0, 0.0, 100, zombie);
  thingsToMove.add(zomb);
  thingsToDisplay.add(zomb);
  thingsToCollide.add(zomb);
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
  // draw background, display displayables, and move moveables
  image(background,0,0);

  for (int m = 0; m < thingsToMove.size(); m++){
    thingsToMove.get(m).move();
  }
    for (Displayable thing: thingsToDisplay){
    thing.display();
  }
}
