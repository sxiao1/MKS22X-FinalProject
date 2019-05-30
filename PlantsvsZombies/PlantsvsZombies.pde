import java.util.*;

ArrayList<Moveable> thingsToMove = new ArrayList<Moveable>();
ArrayList<Displayable> thingsToDisplay = new ArrayList<Displayable>();
ArrayList<Collideable> thingsToCollide = new ArrayList<Collideable>();

ArrayList<Sun> listOfSuns = new ArrayList<Sun>();
ArrayList<Pea> listOfPeas = new ArrayList<Pea>();


PImage background,peashooter,zombie,sunflower,sun,walnut;
PImage ps_seed, sf_seed, wn_seed;

boolean[][] plots = new boolean[5][9];

PImage background,peashooter,zombie,sunflower,sun,lawnmower;
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

  wn_seed = loadImage("wallnut.png");


  SeedPacket seed_pea = new SeedPacket(200, 10, 75, 100);
  thingsToDisplay.add(seed_pea);
  
  SeedPacket seed_sunflower = new SeedPacket(300,10,75,100);
  thingsToDisplay.add(seed_sunflower);
  
  SeedPacket seed_walnut = new SeedPacket(400,10,75,100);
  thingsToDisplay.add(seed_walnut);
  
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
  
  walnut = loadImage("walnut.png");
  image(walnut, 70,80,80,80);
  
  Walnut wallie = new Walnut(70.0,80.0,80.0,100.0,25.0,1000.0,walnut);
  thingsToDisplay.add(wallie);
  thingsToCollide.add(wallie);
  
  peashooter = loadImage("peashooter.png");

  zombie = loadImage("zombie.png");

  int[] zombiex = {800,900,1000,1100,1200};
  int[] zombiey = {40,140,240,340,440};
  for(int i = 20; i >= 0; i--){
    int randNum = (int)(Math.random()*5);
    int randNum2 = (int)(Math.random()*5);
    BasicZombie zomb1 = new BasicZombie(zombiex[randNum2],zombiey[randNum], 80.0, 120.0, 0.0, 1, 100, zombie);
    thingsToMove.add(zomb1);
    thingsToDisplay.add(zomb1);
    thingsToCollide.add(zomb1);
  }
  
  lawnmower = loadImage("lawnmower.png"); 

  for (int i = 0; i < 5; i++){
  LawnMower lawnm = new LawnMower(10.0, 190.0 + 100*i, 100.0, 70.0, 1.0, 100.0, lawnmower); 
  thingsToDisplay.add(lawnm);
  thingsToCollide.add(lawnm); 
  }
  
  sunflower = loadImage("sunflower.png");
  image(sunflower,70,170,85,100);

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
   image(wn_seed, 400,10,75,100);
 
}
 void tintPic(PImage img, int xcor){
   tint(255, 126);
   image(img, xcor, 10,75,100);
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
    GameString needSun = new GameString(str, width/2, height/2, true); 
    thingsToDisplay.add(needSun); 
  }
  // only add plant if there are enough suns and plot is not currently occupied 
   else if(drag == 1 && count >= 100 && plots[plotR][plotC] == false){
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
    else if (drag == 3 && count >= 50  && plots[plotR][plotC] == false){
      plots[plotR][plotC] = true;
      sunc.setCount( sunc.getCount() - 50);
      Walnut wallie = new Walnut(xcor-5,ycor-25, 85, 105,10,100,walnut);
      thingsToDisplay.add(wallie);
      thingsToCollide.add(wallie);
    }
  }
  drag = 0;
}
