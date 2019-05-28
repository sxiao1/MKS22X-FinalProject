import java.util.*;
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
  boolean isTouching(Character c);
}

class GameString implements Displayable{
  String str;
  float x,y;
  boolean display; // whether to display string or not
  
  GameString(String string, float xcor, float ycor, boolean disp){
    str = string;
    x = xcor;
    y = ycor; 
    display = disp;
  }
  
  public void display(){
    if (display){
      PFont f;
      f = createFont("Arial",70,true);
      textFont(f,25);
      textAlign(CENTER,BOTTOM);
      fill(0);
      text(str, x, y);
      
      if (frameCount % 180 == 60){
        display = false; 
      }
    }
  }
}
abstract class Character implements Damageable, Displayable, Collideable{
  float x,y,w,l,HP,damage;
  PImage character;
  Character(float xcor,float ycor,float wid,float len,float dam, float HPnum, PImage image){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    HP = HPnum;
    damage=dam;
    character = image;
  }
  // accessor methods
   float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  float getW(){
    return w;
  }
  float getL(){
    return l;
  }
  float getHP(){
    return HP;
  }
  float getDamage(){
    return damage;
  }
  PImage getImage(){
    return character;
  }
  // when attacked by another character
  void takeHit(float dam){
    this.HP -= dam;
  }
  
  // attack method to be coded in subclasses
  abstract void attack(Character c);
  
  void display(){
    image(character,x,y, w,l);
  }
  
  abstract boolean isTouching(Character other);
  
  }
  
// parent Plant class
abstract class Plant extends Character{
  // takes in x - and y-coordinate, width, length, damage points, starting HP, and plant image
  Plant(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage plantImage){
    super(xcor,ycor,wid,len,dam,startHP,plantImage);
  }
  
  // return true if zombie coordinates overlap with current plant, otherwise return false
   boolean isTouching(Character other){
     if (other.x >= getX() && other.x <= getX() + w
    &&  other.getY() + other.l == getY() + l){
    return true;
    }
    return false;
  }
  
  // if being attacked by a zombie, reduce HP
  void takeHit(float dam){
    this.HP -= dam;
  }
 
}

// Peashooter subclass of Plant
class Peashooter extends Plant{
  float rate; // rate of attack 

  // takes in x- and y-coordinates, width, length, damage points, starting HP, rate of attack, and Peashooter image
  Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
    super(xcor, ycor, wid, len, dam, startHP, peashooter);
    this.rate = rate;
  }
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
    
    if (millis() > 1000 && frameCount % 180 == 0){
      System.out.println(frameCount);
      System.out.println("shoot pea");
      produce();
    }
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
  
  public boolean isTouching(Character other){
    if (x >= other.getX() && x <= other.getX() + other.getW()
     && y >= other.getY() && y <= other.getY() + other.getL()){
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
  }
  
  // sunflower has no offensive ability 
  void attack(Character c){  
  }
  int t = 0;
  void display(){
    super.display();
    if (millis() > 1000 && frameCount % 300 == 0){
      System.out.println("5 seconds have passed");
      produce();
    }
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
abstract class Zombie extends Character implements Damageable, Displayable, Collideable, Moveable{
  float speed;
  
  // takes in x- and y-coordinates, width, length, speed, damage points, starting HP, and zombie image
  Zombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage zombieImage){
    super(xcor, ycor, wid, len, dam, startHP, zombieImage);
    speed = speedNum;
  }

  float getSpeed(){
    return speed;
  }
 
  // if Zombie is touching plant, return true; otherwise return false 
  boolean isTouching(Character other){
    if (x >= other.getX() && x <= other.getX() + other.getW()
    &&  y + l == other.getY() + other.getL()){
    return true;
    }
    return false;
  }
  
  boolean isTouching(Pea other){
    if (other.x >= getX() && other.x <= getX() + w
     && other.y >= getY() && other.y <= getY() + l){
       //System.out.println("zombie is touching pea");
    return true;
    }
    return false;
  }
  
  void move(){
       
    // while still on screen 
    if (x > 0){
      // loop through list of collideables

      speed = 1;
      for (int c = thingsToCollide.size() - 1; c >= 0; c--){
         Collideable thing = thingsToCollide.get(c);
         if (thing instanceof Pea){
           Pea pea = (Pea)thing;
           
           if (this.isTouching(pea) && pea.isActive() && this.getHP() > 0){
            speed = 0; 
            System.out.println("zombie speed:"+speed);
            // pea attacks and "new" pea is created
            pea.attack(this);
            pea.setActive(false);
            thingsToDisplay.remove(pea);
            thingsToMove.remove(pea);
            speed = 1;
           }
         }
        // check if collideable is a plant 
         else if (thing instanceof Plant){
    
          Plant p = (Plant)thing;
          //System.out.println("Zombie is touching plant");
          // if zombie is touching plant and both zombie and plant are alive
          if (this.isTouching(p) && p.getHP() > 0 && this.getHP() > 0){
            speed = 0; 
            // zombie attacks
            attack(p);
            // remove plant from list of displayables if it is dead
           }
            if(p.getHP()==0){
            System.out.println("remove peashooter!");
   
            int plotR = (int)((p.getY() - 80) / 100);
            int plotC = (int)(p.getX() / 78);
            plots[plotR][plotC] = false;
            thingsToDisplay.remove((Collideable)p);
            System.out.println(thingsToDisplay.size());
            speed = 1;
            }
        }
  
      }
       
        // remove this zombie from list of displayables and moveables if it is dead
            if (this.getHP() == 0){
              System.out.println("remove zombie!");
              thingsToDisplay.remove(this);
              thingsToMove.remove(this);
              System.out.println("display:"+thingsToDisplay.size());
              System.out.println("move:"+thingsToMove.size());
            }          
      //x -= speed;
    }
  }
}

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
    noStroke();
    fill(121,83,45);
    rect(x,y,w,l);
    fill(212,190,145);
    rect(x + x/10, y + (2*l/3), w - x/5, l - 70);
    image(sun,x+12,y,50,50);
    f = createFont("Arial",70,true);
    textFont(f,25);
    textAlign(CENTER,BOTTOM);
    fill(0);
    for(int i = 0; i < listOfSuns.size(); i++){
      if(listOfSuns.get(i).collected()){
        count+=25;
        listOfSuns.remove(i);
      }
    }
    text(count,x + w/2, y + l);
    stroke(0);
  }
  
  int getCount(){
    return count;
  }
  
  void setCount(int sunNum){
    count = sunNum;
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
      //fill(255);
      //rect(mouseX, mouseY, 50,50);
      return true;
    }
    return false;
  }
  
}

class notEnoughSuns implements Displayable{
  float count, neededSuns;
  PFont f;
  notEnoughSuns(float count1, float neededSuns1){
    count = count1;
    neededSuns = neededSuns1;
  }
  void display(){
    if(count < neededSuns){
      f = createFont("Arial",70,true);
      textFont(f,25);
      textAlign(CENTER,BOTTOM);
      fill(0);
      String newstr = "You need" + (int)(neededSuns - count) + " more suns";
      text(newstr, width/2, height/2);
    }
  }
}

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();
boolean[][] plots = new boolean[5][9];
ArrayList<Sun> listOfSuns = new ArrayList<Sun>();
ArrayList<Pea> listOfPeas = new ArrayList<Pea>();

PImage background,peashooter,zombie,sunflower,sun;
PImage ps_seed;
PImage sf_seed;
int time;
SunCount sunc;
void setup(){
  // load background, plants, zombies, and suns
  size(1024,600);
  background = loadImage("background.jpg");
  
  time = millis();
  
  sun = loadImage("sun.png");
  image(sun,90,170,50,50); 
  sunc = new SunCount(100, 10, 75,100, 300,sun);

  ps_seed = loadImage("peashooter-seed.jpg");
  
  sf_seed = loadImage("sunflower-seed.jpg");

  SeedPacket seed = new SeedPacket(200, 10, 75, 100);
  thingsToDisplay.add(seed);
  
  SeedPacket seed1 = new SeedPacket(300,10,75,100);
  thingsToDisplay.add(seed1);
  
  fill(255);
  rect(70,80,70,70); //size 70x70
  rect(70,80+100,70,70);//space between plots is 20
  
 peashooter = loadImage("peashooter.png");
  image(peashooter,70,80, 80,80);
  /*Peashooter(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage peashooter){
  Peashooter peashoot = new Peashooter(70.0,280.0, 80, 80, 25.0,1000,5.0, peashooter);
  thingsToDisplay.add(peashoot);
  thingsToCollide.add(peashoot);
  peashoot.display();*/
  
  zombie = loadImage("zombie.png");
  image(zombie,900,80, 80,120);
/*  BasicZombie zomb = new BasicZombie(900.0,240.0, 80.0, 120.0, 0.0, 1, 100, zombie);
  thingsToMove.add(zomb);
  thingsToDisplay.add(zomb);
  thingsToCollide.add(zomb);
  zomb.display();*/
  int[] zombiex = {800,900,1000,1100,1200};
  int[] zombiey = {40,140,240,340,440};
  for(int i = -1; i >= 0; i--){
    int randNum = (int)(Math.random()*5);
    int randNum2 = (int)(Math.random()*5);
    BasicZombie zomb1 = new BasicZombie(zombiex[randNum2],zombiey[randNum], 80.0, 120.0, 0.0, 1, 100, zombie);
    thingsToMove.add(zomb1);
    thingsToDisplay.add(zomb1);
    thingsToCollide.add(zomb1);
  }
  
  sunflower = loadImage("sunflower.png");
  image(sunflower,70,170,85,100);
  //  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
  /*nflower sunf = new Sunflower(70.0,360.0, 85, 100, 10.0,100.0,5.0, sunflower);
  thingsToDisplay.add(sunf);
  thingsToCollide.add(sunf);
  sunf.display(); */

  thingsToDisplay.add(sunc);
  
  for(int r = 0; r< plots.length; r++){
    for(int c = 0; c < plots[0].length; c++){
      plots[r][c] = false;
    }
  }
 
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
 // seeds
   image(ps_seed, 200,10,75,100);
   image(sf_seed, 300,10,75,100);
 
}
 void tintPic(PImage img, int xcor){
   tint(255, 126);
   image(img, xcor, 10,75,100);
 }

int drag = 0; // check if mouse is being dragged
int plant = 0;
void mouseDragged(){
  //fill(255);
  //rect(mouseX, mouseY, 50,50);
  //100, 20, 75, 100
  // if in seed packet 
  System.out.println("update plant");
  //PImage plant = sunflower;
  if (mouseX >= 200 && mouseX <=200 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
      drag = 1;
      System.out.println("drag on!!");
      plant = 0;
    }
  else if (mouseX >= 300 && mouseX <= 300 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
      drag = 2;
      System.out.println("drag on!!");
      plant = 1;
    }
  if(plant ==0){
    image(peashooter,mouseX,mouseY,80,80);
  }
  else{
    image(sunflower,mouseX,mouseY,80,80);
  }
    
}

int duration = 5000;
int track = 0;
int start = 0;
void mouseReleased(){
  int count = sunc.getCount(); // number of suns collected

  // top left-most plot coordinates
  float xcor = 78;
  float ycor = 80; 
  int plotR = 0;
  int plotC = 0;
  
  // if mouse is being dragged
  if (drag > 0){
   // find the proper x, y coordinates to "snap" to
   if (mouseX >= 78){
     xcor = 78*( (int)(mouseX / 78));
     System.out.println("change plot column");
     plotC = (int)(mouseX / 78) - 1;
   }
    if (mouseY >= 80){
      System.out.println(mouseY);
      ycor = 80 + 100*( (mouseY - 80 )/100);
      plotR = ((int)mouseY - 80 )/100;
    }

  System.out.println("plotR,C: "+plotR+", "+plotC);
  // check if there are enough suns and if the plot is already occupied
  
  if (drag == 1 && count < 100){
    
    String str = "Need more suns";
    GameString needSun = new GameString(str, width/2, height/2, true); 
    thingsToDisplay.add(needSun);
    
  }
    if(drag == 1 && count >= 100 && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      sunc.setCount( sunc.getCount() - 100);
      Peashooter peashoot = new Peashooter(xcor, ycor, 80, 80, 25.0,100, 5,peashooter);
      thingsToDisplay.add(peashoot);
      thingsToCollide.add(peashoot);
    }
    else if(drag == 2 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      sunc.setCount( sunc.getCount() - 50);
      Sunflower sun = new Sunflower(xcor-5,ycor - 25,85,105,10,25,5,sunflower);
      thingsToDisplay.add(sun);
      thingsToCollide.add(sun);
    }
  }
  drag = 0;
}
