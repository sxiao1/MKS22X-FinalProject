import java.util.*;
import processing.sound.*;
SoundFile file;
SoundFile zomieDead;

boolean runGame; 

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();

ArrayList<Sun> listOfSuns = new ArrayList<Sun>();
ArrayList<Pea> listOfPeas = new ArrayList<Pea>();

PImage background,peashooter,zombie,sunflower,sun,walnut, lawnmower,cherry;
PImage ps_seed, sf_seed, wn_seed,cb_seed;

boolean[][] plots = new boolean[5][9];
int[] numPlants = new int[5];
ArrayList<Position> lanes = new ArrayList<Position>();

int time;
SunCount sunc;

Menu menu;
//boolean addZomb;
void setup(){
  
  menu = new Menu(0);
  file = new SoundFile(this, "theme.mp3");
  file.play();
  zomieDead = new SoundFile(this, "Zombie Moan.mp3");
  
  runGame = true;
  // load background, plants, zombies, and suns
  size(1024,600);
  background = loadImage("background.jpg");
  
  time = millis();
  
  sun = loadImage("sun.png");
 // image(sun,90,170,50,50); 
  sunc = new SunCount(100, 10, 75,100, 300,sun);

  ps_seed = loadImage("peashooter-seed.jpg");
  sf_seed = loadImage("sunflower-seed.jpg");
  wn_seed = loadImage("wallnut.png");
  cb_seed = loadImage("cherryBomb.png");

  SeedPacket seed_pea = new SeedPacket(200, 10, 75, 100);
  thingsToDisplay.add(seed_pea);
  
  SeedPacket seed_sunflower = new SeedPacket(300,10,75,100);
  thingsToDisplay.add(seed_sunflower);
  
  SeedPacket seed_walnut = new SeedPacket(400,10,75,100);
  thingsToDisplay.add(seed_walnut);
  
  SeedPacket seed_cherry = new SeedPacket (500, 10, 75, 100);
  thingsToDisplay.add(seed_cherry);
  
  peashooter = loadImage("peashooter.png");
  cherry = loadImage("cherry.png");
  walnut = loadImage("walnut.png");
  sunflower = loadImage("sunflower.png");
  zombie = loadImage("zombie.png");
  lawnmower = loadImage("lawnmower.png"); 
  

  int[] zombiex = {1200, 1400, 1600, 1800, 2000};
  int[] zombiey = {40,140,240,340,440};
 
   int randNum = 0;
   int randNum2 = 0;
   float randNum3 = 0;
    
   for (int i = 0; i < 5; i++){
    randNum = (int)(Math.random()*5);
    randNum2 = (int)(Math.random()*5);
    randNum3 = (float)(Math.random()*1) + 0.1;
    // Zombie(float xcor, float ycor, float wid, float len, float speedNum, float dam, float startHP, PImage zombieImage)
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2],zombiey[randNum], 80.0, 120.0, randNum3, 1, 6, zombie);
      System.out.println("zombie speed:" + randNum3);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
      System.out.println("number of zombies: " + i);
   }

  for (int i = 0; i < 5; i++){
    LawnMower lawnm = new LawnMower(0.0, 90.0 + 100*i, 100.0, 70.0, 1.0, 100.0, lawnmower); 
    thingsToDisplay.add(lawnm);
    thingsToCollide.add(lawnm); 
  }

  thingsToDisplay.add(sunc);
  
  for(int r = 0; r< plots.length; r++){
    for(int c = 0; c < plots[0].length; c++){
      plots[r][c] = false;
    }
  }
 
   for (int r = 0; r < numPlants.length; r++){
       numPlants[r] = 0;
       lanes.add(new Position(r, numPlants[r]));
   }
   
    draw();
    mouseDragged();
    mouseReleased();
 
}

int numZombies = 0;
boolean addZomb = true;
boolean finalWave = true;
int i = 0;
int[] zombiex = {800,900,1000,1100,1200};
int[] zombiey = {40,140,240,340,440};
int n = 0;
int times = 1;
void draw(){
  
if (frameCount % 240 == 60){
  if(addZomb){
    int randNum = (int)(Math.random()*5);
    int randNum2 = (int)(Math.random()*5);
    
    int rowMax = 0; 
    int probability = (int)(Math.random() * 70);
    
    for (int l = 1; l < numPlants.length; l++){
      if (numPlants[l] > numPlants[rowMax]){
        rowMax = l;
      }
    }
    System.out.println("rowMAx: "+rowMax);
    
    if (probability < 40){
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[rowMax], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
      System.out.println("num of zombs :" + i);
    }
    else{ 
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[randNum], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
      System.out.println("num of zombs :" + i);
    }
   if(i >= 10){
     addZomb = false;
     System.out.println("more than " + i + " zombs");
   }
  }
  else{
      if (times == 1){
          String gameOver = "FINAL WAVE";
          GameString g = new GameString(gameOver, width/2, height/2, 80, true);
          thingsToDisplay.add(g);
          times = 0;
        }
      //if(finalWave) {
      while(n <= 8){
      System.out.println("final wave");
      int randNum = (int)(Math.random()*5);
      int randNum2 = (int)(Math.random()*5);
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[randNum], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      System.out.println("final wave zombies : " + n);
      n++;
      }
    
  }
  

     }
      // draw background, display displayables, and move moveables
     image(background,0,0);

    for (int d = 0; d < thingsToDisplay.size(); d++){
      thingsToDisplay.get(d).display();
    }
    
  if (runGame){
    for (int m = 0; m < thingsToMove.size(); m++){
      thingsToMove.get(m).move();
    }
  }
  
  else{
    // GameString(String string, float xcor, float ycor, boolean disp){
    String gameOver = "GAME OVER";
    GameString g = new GameString(gameOver, width/2, height/2, 150, true);
    thingsToDisplay.add(g);
  }
       // seeds
     image(ps_seed, 200,10,75,100);
     image(sf_seed, 300,10,75,100);
     image(wn_seed, 400,10,75,100);
     image(cb_seed, 500, 10,75,100);
     
     // random sun from sky every few seconds
  if (frameCount % 1000 == 5){
    Sun sunny = new Sun((float)Math.random()*(width - 500) + 100, 0.0, height - 100, 1.0, sun);
    System.out.println("add sun");
    thingsToDisplay.add(sunny);
    thingsToMove.add(sunny);
    listOfSuns.add(sunny);
  }
}


int drag = 0; // check if mouse is being dragged
int plant = 0; // check which plant to use
void mouseDragged(){

  // if in seed packet 
  System.out.println("update plant");
  //PImage plant = sunflower;
  if (mouseX >= 200 && mouseX <= 200 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
      drag = 1;
      plant = 0;
    }
  else if (mouseX >= 300 && mouseX <= 300 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
      drag = 2;
      plant = 1;
    }
    
  else if (mouseX >= 400 && mouseX <= 400 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
    drag = 3;
    plant = 2;
  }
  else if(mouseX >= 500 && mouseX <= 4500 + 75 && mouseY >= 10 && mouseY <= 10 + 100){
    drag = 4;
    plant = 3;
  }
  if (drag == 1 && plant == 0){
    image(peashooter,mouseX,mouseY,80,80);
  }
  else if (drag == 2 && plant == 1){
    image(sunflower,mouseX,mouseY,80,100);
  }
  else if (drag == 3 && plant == 2){
    image(walnut,mouseX,mouseY,80,100);
  }
  else if(drag == 4 && plant == 3){
    image(cherry,mouseX,mouseY, 80,100);
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

  // check if there are enough suns and if the plot is already occupied
  
  if (drag == 1 && count < 100 || drag == 2 && count < 50 || drag == 3 && count < 50){
    
    String str = "NEED MORE SUNS";
    GameString needSun = new GameString(str, width/2, height/2, 70, true); 
    thingsToDisplay.add(needSun); 
  }
  // only add plant if there are enough suns and plot is not currently occupied 
   else if(drag == 1 && count >= 100 && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      numPlants[plotR] += 1;
      lanes.get(plotR).setNum( numPlants[plotR] ); 
      System.out.println("number of plants in row" + plotR+": "+numPlants[plotR]);
      
      sunc.setCount( sunc.getCount() - 100);
      //Plant(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage plantImage)
      Peashooter peashoot = new Peashooter(xcor, ycor, 80, 80, 25.0,1000, 5,peashooter);
      thingsToDisplay.add(peashoot);
      thingsToCollide.add(peashoot);
    }
    else if(drag == 2 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
       numPlants[plotR] += 1;
        lanes.get(plotR).setNum( numPlants[plotR] ); 
       System.out.println("number of plants in row" + plotR+": "+numPlants[plotR]);
      sunc.setCount( sunc.getCount() - 50);
      //  Sunflower(float xcor, float ycor, float wid, float len, float dam, float startHP, float rate, PImage sunflower){
      Sunflower sun = new Sunflower(xcor-5,ycor - 25,85,105,0,1000,5,sunflower);
      thingsToDisplay.add(sun);
      thingsToCollide.add(sun);
    }
    else if (drag == 3 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      numPlants[plotR] += 1;
      System.out.println("number of plants in row" + plotR+": "+numPlants[plotR]);
      sunc.setCount( sunc.getCount() - 50);
      //  Walnut(float xcor, float ycor, float wid, float len, float dam, float startHP, PImage walnut){
      Walnut wallie = new Walnut(xcor-5,ycor-25, 85, 105,10,1000,walnut);
      thingsToDisplay.add(wallie);
      thingsToCollide.add(wallie);
    }
    else if(drag == 4 && count >= 150 && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      numPlants[plotR] += 1;
      System.out.println("number of plants in row" + plotR+": "+numPlants[plotR]);
      sunc.setCount( sunc.getCount() - 150);
      Cherry cherryb = new Cherry(xcor-5,ycor-25, 85, 105,1000,100,cherry);
      thingsToDisplay.add(cherryb);
      thingsToCollide.add(cherryb);
    }
  }
  drag = 0;
}

void keyPressed(){
  if (key == '1'){
    menu.setMode(1);
  }
  else if (key == '2'){
    menu.setMode(2);
  }
}
