import java.util.*;
import processing.sound.*;
SoundFile file;
SoundFile zombieDead;

boolean runGame; 
boolean reset; 
boolean lose;

Menu menu;
int menuMode; 

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();

ArrayList<Sun> listOfSuns = new ArrayList<Sun>();
ArrayList<Pea> listOfPeas = new ArrayList<Pea>();

PImage startscreen, startbg, background,peashooter,zombie,sunflower,sun,walnut, lawnmower;
PImage ps_seed, sf_seed, wn_seed;

boolean[][] plots = new boolean[5][9]; // KEEP TRACK OF WHICH PLOTS HAVE ACTIVE PLANTS 
int[] numPlants = new int[5]; // NUMBER OF PLANTS IN EACH ROW 
ArrayList<Position> lanes = new ArrayList<Position>(); // POSITIONS OF ROWS WITH ROW NUMBER, NUMBER OF PLANTS 

SeedPacket seed_pea, seed_sunflower, seed_walnut; 

int time;
SunCount sunc;


void setup(){
  // LOAD IMAGES 
  startscreen = loadImage("startscreen.jpg");
  startbg = loadImage("mainmenubackground.jpg");
  
  menu = new Menu(0, startscreen, startbg);
  menuMode = 0; 
  
  // play theme song
  file = new SoundFile(this, "theme.mp3");
  file.loop();
  
  // zombie death sound effect
  zombieDead = new SoundFile(this, "Zombie Moan.mp3");
  
  // run game?
  runGame = false;
  reset = false; 
  lose = false;
  
  size(1024,600);
  background = loadImage("background.jpg");
  
  // ADD SUNCOUNT, SEED PACKETS, ZOMBIES TO DISPLAY, COLLIDE, AND/OR MOVE LISTS
  sun = loadImage("sun.png");
  sunc = new SunCount(100, 10, 75,100, 300,sun);
  thingsToDisplay.add(sunc);
  
  ps_seed = loadImage("peashooter-seed.jpg");
  sf_seed = loadImage("sunflower-seed.jpg");
  wn_seed = loadImage("wallnut.png");

  seed_pea = new SeedPacket(200, 10, 75, 100, ps_seed);
  thingsToDisplay.add(seed_pea);
  
  seed_sunflower = new SeedPacket(300,10,75,100, sf_seed);
  thingsToDisplay.add(seed_sunflower);
  
  seed_walnut = new SeedPacket(400,10,75,100, wn_seed);
  thingsToDisplay.add(seed_walnut);
  
  peashooter = loadImage("peashooter.png");
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
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
   }

  for (int i = 0; i < 5; i++){
    LawnMower lawnm = new LawnMower(0.0, 90.0 + 100*i, 100.0, 70.0, 1.0, 100.0, lawnmower); 
    thingsToDisplay.add(lawnm);
    thingsToCollide.add(lawnm); 
  }
  sunc.setCount(300); 
  thingsToDisplay.add(sunc);
  
  for(int r = 0; r< plots.length; r++){
    for(int c = 0; c < plots[0].length; c++){
      plots[r][c] = false;
    }
  }

    mouseClicked(); 
    draw();
    mouseDragged();
    mouseReleased();
    
}

int numZombies = 0;
boolean addZomb = true;
boolean finalWave = true;

int i = 0;
int[] zombiex = {1200, 1400, 1600, 1800, 2000};
int[] zombiey = {40,140,240,340,440};
int n = 0;
int times = 1;

void draw(){

// ADD ZOMBIES AT INTERVALS WHILE GAME IS RUNNING, CAPPED AT 10 ZOMBIES
if (runGame && frameCount % 240 == 60){
  if(addZomb){
    int randNum = (int)(Math.random()*5);
    int randNum2 = (int)(Math.random()*5);
    
    int rowMax = 0; 
    int probability = (int)(Math.random() * 100);
    
    for (int l = 1; l < numPlants.length; l++){
      if (numPlants[l] > numPlants[rowMax]){
        rowMax = l;
      }
    }

    if (probability < 40){
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[rowMax], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
    }
    else{ 
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[randNum], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      i++;
    }
   if(i >= 10){
     addZomb = false;
   }
  }
  else{
      if (times == 1){
          String gameOver = "FINAL WAVE";
          GameString g = new GameString(gameOver, width/2, height/2, 80, true);
          thingsToDisplay.add(g);
          times = 0;
        }

      while(n <= 8){
      int randNum = (int)(Math.random()*5);
      int randNum2 = (int)(Math.random()*5);
      BasicZombie zomb1 = new BasicZombie(zombiex[randNum2], zombiey[randNum], 80.0, 120.0, 2.0, 1, 100, zombie);
      thingsToMove.add(zomb1);
      thingsToDisplay.add(zomb1);
      thingsToCollide.add(zomb1);
      n++;
      }
    
  }
  
}
         
// display the menu     
  menu.display();
  
  if (runGame){
     // draw background, display displayables, and move moveables
     image(background,0,0);
     
     // DISPLAY IN GAME MENU
     menu.displayInGameMenu(); 
     
     // DISPLAY 
    for (int d = 0; d < thingsToDisplay.size(); d++){
      thingsToDisplay.get(d).display();
    }
    
   // random sun from sky every few seconds
  if (frameCount % 1000 == 5){
    Sun sunny = new Sun((float)Math.random()*(width - 500) + 100, 0.0, height - 100, 1.0, sun);
    thingsToDisplay.add(sunny);
    thingsToMove.add(sunny);
    listOfSuns.add(sunny);
  }
   
   // MOVE
    for (int m = 0; m < thingsToMove.size(); m++){
      thingsToMove.get(m).move();
    }
  }
  
  else{
    // IF GAME IS OVER, PRINT STRING
    if (lose){
    String gameOver = "GAME OVER";
    GameString g = new GameString(gameOver, width/2, height/2, 150, true);
    thingsToDisplay.add(g);
    }
  }
         
}

int drag = 0; // check if mouse is being dragged
int plant = 0; // check which plant to use

void mouseDragged(){
if (runGame){
  // if in seed packet, check if user has selected peashooter, sunflower, or walnut
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
  // display images to move with computer mouse 
  if (drag == 1 && plant == 0){
    image(peashooter,mouseX,mouseY,80,80);
  }
  else if (drag == 2 && plant == 1){
    image(sunflower,mouseX,mouseY,80,100);
  }
  else if (drag == 3 && plant == 2){
    image(walnut,mouseX,mouseY,80,100);
 }
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
  
  if (runGame){
  // if mouse is being dragged
  if (drag > 0){
    
   // find the proper x, y coordinates to "snap" to
   if (mouseX >= 78){
     xcor = 78*( (int)(mouseX / 78));
     plotC = (int)(mouseX / 78) - 1;
   }
    if (mouseY >= 80){
      ycor = 80 + 100*( (mouseY - 80 )/100);
      plotR = ((int)mouseY - 80 )/100;
    }

  // check if there are enough suns and if the plot is already occupied
  
  if (drag == 1 && count < 100 || drag == 2 && count < 50 || drag == 3 && count < 50){
    
    String str = "NEED MORE SUNS!";
    GameString needSun = new GameString(str, width/2, height/2, 70, true); 
    thingsToDisplay.add(needSun); 
  }
  
  // only add plant if there are enough suns and plot is not currently occupied 
  
  // PEASHOOTER
   else if(drag == 1 && count >= 100 && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      numPlants[plotR] += 1;
      lanes.get(plotR).setNum( numPlants[plotR] ); 

      sunc.setCount( sunc.getCount() - 100);
      Peashooter peashoot = new Peashooter(xcor, ycor, 80, 80, 25.0,1000, 5,peashooter);
      thingsToDisplay.add(peashoot);
      thingsToCollide.add(peashoot);
    }
    
    // SUNFLOWER
    else if(drag == 2 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
       numPlants[plotR] += 1;
       lanes.get(plotR).setNum( numPlants[plotR] ); 
       sunc.setCount( sunc.getCount() - 50);
      
      Sunflower sun = new Sunflower(xcor-5,ycor - 25,85,105,0,1000,5,sunflower);
      thingsToDisplay.add(sun);
      thingsToCollide.add(sun);
    }
    
    // WALNUT
    else if (drag == 3 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      numPlants[plotR] += 1;

      sunc.setCount( sunc.getCount() - 50);

      Walnut wallie = new Walnut(xcor-5,ycor-25, 85, 105,10,1000,walnut);
      thingsToDisplay.add(wallie);
      thingsToCollide.add(wallie);
    }
  }
  drag = 0;
  }
}

void mouseClicked(){
   menu.act();
}
