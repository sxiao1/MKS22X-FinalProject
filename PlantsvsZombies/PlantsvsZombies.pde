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
  Pea myPea;

  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Peashooter image
  Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, wid, len, dam, startHP, peashooter);
    this.rate = rate;
    myPea = new Pea(xcor + wid, ycor + 20, 30.0, 30.0, 3.0, 25.0, true);
    thingsToDisplay.add(myPea);
    thingsToMove.add(myPea);
    thingsToCollide.add(myPea); 
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

class Pea implements Displayable, Moveable, Collideable{
  float origX, origY; 
  float x,y,w,l,speed,damage;
  boolean active; 
  
public Pea(float xcor, float ycor, float wid, float len, float speedNum, float dam, boolean active){
    x = xcor;
    origX = xcor;
    y = ycor;
    origY = ycor;
    w = wid;
    l = len;
    speed = speedNum;
    damage = dam; 
    this.active = active;
  }
  
  public void display(){
    fill(6,214,21); // green color
    ellipse(x, y, w, l); // create the ellipse shape of the pea
  }
  
  // move 
  public void move(){
    x += 3;
  }
  // attack zombie
  public void attack(Zombie z){
    z.takeHit(25.0);
    System.out.println("pea attacked: " + z.getHP());
  }
  public void reset(){
    x = origX; 
    y = origY;
  }
  
  // not used
  public boolean isTouching(Plant other){
    return false;
  }
  
  public boolean isTouching(Zombie other){
    if (x >= other.getX() && x <= other.getX() + other.w
     && y >= other.getY() && y <= other.getY() + l){
       System.out.println("pea is touching zombie");
    return true;
    }
    return false;
  }
  
  public boolean isActive(){
    return active;
  }
  
  public void setActive(boolean status){
    active = status;
  }
}

// Sunflower subclass of Plant
class Sunflower extends Plant{
  float rate; // rate of attack 
  PImage sunImage = loadImage("sun.png");
  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Sunflower image
  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
    super(xcor, ycor, wid, len, dam, startHP, sunflower);
    this.rate = rate;
    produce();
  }
  
  // sunflower has no offensive ability 
  void attack(Zombie z){  
  }
  
  void display(){
    super.display();
  }
  
  // instantiate a new sun from the sunflower's coordinates
  void produce(){
    Sun sun = new Sun(this.getX(), this.getY(), 1.0, sunImage);
    System.out.println("add sun");
    thingsToDisplay.add(sun);
    thingsToMove.add(sun);
    listOfSuns.add(sun);
  }
}

// Sun class, for the Sunflower class and also randomly generated suns
class Sun implements Moveable, Displayable{
  float x,y,speed;
  int sunCount;
  PImage sun;
  // takes in x- and y-coordinates and speed of movement 
  Sun(float xcor, float ycor, float sunSpeed, PImage sunImage){
    x = xcor;
    y = ycor;
    speed = sunSpeed;
    sun = sunImage;
  }
  void display(){
    image(sun,x,y,50,50);
  }
  void move(){
    if (y < height - 100){
      y += speed;
    }
    if (collected() ){
      sunCount++;
      System.out.println("sun has been clicked");
      thingsToDisplay.remove(this);
      thingsToMove.remove(this);
    }
  }
  
  // if the user clicks on the sun, then it has been collected 
  boolean collected(){
    if (mousePressed && mouseX >= this.x && mouseX <= this.x + 50 && mouseY >= this.y && mouseY <= this.y + 50){
    return true;
    }
    return false;
  }
  int getSun(){
    return sunCount;
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
  
  boolean isTouching(Pea other){
    if (other.x >= getX() && other.x <= getX() + w
     && other.y >= getY() && other.y <= getY() + l){
       System.out.println("zombie is touching pea");
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
       
         if (thing instanceof Pea){
           Pea pea = (Pea)thingsToCollide.get(i);
           
           if (this.isTouching(pea) && pea.isActive() && this.getHP() > 0){
            super.speed = 0; 
            // pea attacks and "new" pea is created
            pea.attack(this);
            pea.reset();
            System.out.println("zombie hp:" + getHP());
  
            System.out.println("remove pea");
            
           }
           else{
             super.speed = 3;
           }
         }
        // check if collideable is a plant 
         else if (thing instanceof Plant){
    
          Plant p = (Plant)thingsToCollide.get(i);
          // if zombie is touching plant and both zombie and plant are alive
          if (this.isTouching(p) && p.getHP() > 0 && this.getHP() > 0){
            super.speed = 0; 
            // zombie attacks
            System.out.println("Zombie is touching plant");
            attack(p);
            // remove plant from list of displayables if it is dead
            if(p.getHP()==0){
            System.out.println("remove peashooter!");
            thingsToDisplay.remove((Collideable)p);
            System.out.println(thingsToDisplay.size());
            }
            
           }
           else{
             super.speed = 3;
           }
        }
        i++;
      }
       
        // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              System.out.println("remove zombie!");
              thingsToDisplay.remove(this);
              thingsToMove.remove(this);
              System.out.println("display:"+thingsToDisplay.size());
              System.out.println("move:"+thingsToMove.size());
            }
            
      x -= speed;
    }
  }

}
class SunCount implements Displayable{
  float x,y,w,l;
  int count;
  PImage sun;
  PFont f;
  SunCount(float xcor,float ycor,float wid,float len, int counter, PImage sunImg){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    count = counter;
    sun = sunImg;
  }
  void display(){
    fill(121,83,45);
    rect(x,y,w,l);
    image(sun,x+12,y,50,50);
    f = createFont("Arial",70,true);
    textFont(f,30);
    fill(0);
    for(int i =0; i < listOfSuns.size(); i++){
      if(listOfSuns.get(i).collected()){
        count+=25;
        listOfSuns.remove(i);
      }
    }
    text(count,x+20,y+80);
  }
  
  void addCount(){
    count++;
  }
}
class SeedPacket implements Displayable{
  float x,y,w,l;
  SeedPacket(float xcor, float ycor, float wid, float len){
    x = xcor;
    y = ycor;
    w = wid;
    l = len; 
  }
  
  void display(){
    fill(121,83,45);
    rect(x,y,w,l);
    if (isClicked() ){
      System.out.println("seed clicked");
    }
  }
  
  boolean isClicked(){
    if (mousePressed && mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.l){
      fill(255);
      rect(mouseX, mouseY, 50,50);
      return true;
    }
    return false;
  }
  
}

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();
boolean[][] plots = new boolean[5][9];
ArrayList<Sun> listOfSuns = new ArrayList<Sun>();

PImage background,peashooter,zombie,sunflower,sun;
PImage ps_seed;
  
void setup(){
  // load background, plants, zombies, and suns
  size(1024,600);
  background = loadImage("background.jpg");
  
  ps_seed = loadImage("peashooter-seed.jpg");

  SeedPacket seed = new SeedPacket(200, 10, 75, 100);
  thingsToDisplay.add(seed);
  
  fill(255);
  rect(70,80,70,70); //size 70x70
  rect(70,80+100,70,70);//space between plots is 20
  
  peashooter = loadImage("peashooter.png");
  image(peashooter,70,80, 80,80);
  
  Peashooter peashoot = new Peashooter(70.0,280.0, 80, 80, 10.0,25.0,5.0, peashooter);
  thingsToDisplay.add(peashoot);
  thingsToCollide.add(peashoot);
  peashoot.display();
  
  zombie = loadImage("zombie.png");
  image(zombie,900,80, 80,120);
  BasicZombie zomb = new BasicZombie(900.0,240.0, 80.0, 120.0, 0.0, 1.0, 100, zombie);
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
  
  SunCount sunc = new SunCount(100, 10, 75,100, 0,sun);
  thingsToDisplay.add(sunc);
 
  draw();
  mouseDragged();
  mouseReleased();
  
}
int sunCount = 0;
void draw(){
  
  // draw background, display displayables, and move moveables
  image(background,0,0);

  for (int m = 0; m < thingsToMove.size(); m++){
    thingsToMove.get(m).move();
  }

  for (int d = 0; d < thingsToDisplay.size(); d++){
    thingsToDisplay.get(d).display();
  }
 // pea shooter seed
   image(ps_seed, 200,10,75,100);
 
}

int drag = 0; // check if mouse is being dragged

void mouseDragged(){
  fill(255);
  rect(mouseX, mouseY, 50,50);
  //100, 20, 75, 100
  // if in seed packet 
  if (mouseX >= 200 && mouseX <=200 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
      drag = 1;
      System.out.println("drag on!!");
    }
}

void mouseReleased(){
  
  // top left-most plot coordinates
  float xcor = 78;
  float ycor = 80; 
  
  if (drag == 1){
    System.out.println("drag release!! ");
   if (mouseX >= 78){
     xcor = 78*( (int)mouseX / 78);
   }
    if (mouseY >= 80){
      System.out.println(mouseY);
      ycor = 80 + 100*( (mouseY - 80 )/100);

    }

  Peashooter peashoot = new Peashooter(xcor, ycor, 80, 80, 10.0,25.0,5.0, peashooter);
  thingsToDisplay.add(peashoot);
  thingsToCollide.add(peashoot);
  }
  drag = 0;
}