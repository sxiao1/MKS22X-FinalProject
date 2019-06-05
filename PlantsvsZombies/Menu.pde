class Menu{

  int option, x, y; 
  float mode;
  PImage screen, startbg;
  String title;
  
  public Menu(float mode, PImage startscreen, PImage startbg){
    this.mode = mode;
    x = width/2;
    y = height / 2;
    screen = startscreen;
    this.startbg = startbg;
    title = "MENU";
    option = 0;
  }
  
 
  public void display(){
    // START SCREEN
    if (mode == 0){
  
    image(startscreen, 0,0);
    startscreen.resize(1024, 600);
    image(startscreen, 0,0);
    rectMode(CORNER);
    fill(155,0,155);
    rect(315, 530, 400, 45); 

      if (mousePressed && mouseX >= 315 && mouseX <= 715 && mouseY >= 530 && mouseY <= 575){
      System.out.println("CLICK HERE TO START IS PRESSED");
      mode = 1; 
      }
    }
    
    // MAIN MENU
    if (mode == 1){
      
      image(startbg, 0,0);
      startbg.resize(1024, 600);
      image(startbg, 0,0);
      
      rectMode(CENTER);
      // magenta
      fill(155,0,155);
      noStroke();
      rect(x,y, width/2, height - 100);
      fill(255);
      textSize(85); 
      textAlign(CENTER,CENTER);
      title = "MAIN MENU";
      text(title, width/2, 100);
      
      options(); 
    
    if (mousePressed){
      
        float xCorner = x - ((width/2 - 100)/2);
        float xWidth = width/2 - 100;
        float yCorner = (height/3) - (75/2); 
        float yLength = 75; 
 
        if (mouseX >= xCorner && mouseX <= xCorner + xWidth){
         // START GAME
          if (mouseY >= yCorner && mouseY <= yCorner + yLength){
             System.out.println("START");
             option = 1;
             mode = 2;
             runGame = true;
          }
          else if (mouseY > yCorner + 110 && mouseY <= yCorner + yLength + 110){
            System.out.println("INSTRUCTIONS");
            instructions();
            option = 2;
            mode = 1.5;
            
          }
          else if (mouseY > yCorner + 220 && mouseY <= yCorner + yLength + 220){
            
            System.out.println("QUIT GAME");
            option = 3;
            runGame = false;
            exit();
          }
        }
      }
    }
        // CHECK IF BACK IS PRESSED
        if (mode == 1.5 && option == 2){
            if (mousePressed && mouseX >= width/2 && mouseX <= 3*width/4 && mouseY >= 550 && mouseY <= 600){
              System.out.println("BACK PRESSED");
              mode = 1;
        }
       }
      
      if (mode == 2){
        inGameMenu();
        options();
      }
      
    
  }
  
  public void setMode(int newMode){
    mode = newMode;
  }
  
  public void options(){
    
    fill(0,0,255);
    noStroke();
    rectMode(CENTER);
    
   if (mode == 1){ 
    //  START GAME
    rect(x,height/3, width/2 - 100, 75);
      fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("START GAME", x, height/3);
    
    // INSTRUCTIONS
    fill(0,0,255);
    noStroke();
    rectMode(CENTER);
     rect(x,height/3 + 110, width/2 - 100, 75); 
     fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("INSTRUCTIONS", x, height/3 + 110);
    
    // QUIT
    fill(0,0,255);
    noStroke();
    rectMode(CENTER);
     rect(x,height/3 + 220, width/2 - 100, 75); 
     fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("QUIT", x, height/3 + 220);
   }
   
   else if (mode == 2){
      rectMode(CENTER);
      // magenta
      fill(155,0,155);
      noStroke();
      rect(width/2, height/2, width/2, height);
      fill(255);
      textSize(70); 
      textAlign(CENTER,CENTER);
      title = "MENU";
      text(title, width/2, 25);
      
    fill(0,0,255);
    noStroke();
    rectMode(CENTER);
    
     //  RESUME GAME
      rect(x,height/6, width/2 - 100, 75);
      fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("RESUME GAME", x, height/6);
    
    // RESTART LEVEL 
    fill(0,0,255);
    rect(x,height/6 + 110, width/2 - 100, 75);
      fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("RESTART LEVEL", x, height/6 + 110);
    
    // INSTRUCTIONS
    fill(0,0,255);
     rect(x,height/6 + 220, width/2 - 100, 75); 
     fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("INSTRUCTIONS", x, height/6 + 220);
    
    // MAIN MENU 
    fill(0,0,255);
    rect(x,height/6 + 330, width/2 - 100, 75); 
     fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("MAIN MENU", x, height/6 + 330);
      
    // QUIT
    fill(0,0,255);
     rect(x,height/6 + 440, width/2 - 100, 75); 
     fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("QUIT", x, height/6 + 440);
    
   }
  }
  
  // display description and instructions 
  public void instructions(){
    fill(255);
      
      rectMode(CENTER);
      // magenta
      fill(155,0,155);
      noStroke();
      rect(x,y, width/2, height - 100);
    String description = "Plants vs. Zombies is tower defense game takes place in your front lawn, where you must defend your home against waves of zombies. You will use seed packets to plant a variety of plants that either attack or defend your house from zombies. You can purchase plants from an inventory bar at the top of the screen according to how many suns you collect throughout the game. Sun is grown by the sunflower plant, but it is also generated randomly throughout the game. Zombies walk slowly towards the house and must be shot down before they reach the plants, or else they will destroy the plants and eventually break into your home. The game ends when zombies enter the house and eat your brains.";
    String instruct = "At the start of the game, you are given 300 suns. Use them to plant a Peashooter, Sunflower, or Walnut by clicking the appropriate seed packet and dropping the plant onto a plot of land. NOTE: You may only purchase a plant if you have enough Suns for it.\n\nCollect Suns that drop from the sky or Sunflower plants by clicking on them. Keep track of the number of Suns by looking at the sun counter on the top left corner of the screen.\n\nDefend your lawn by using your plants strategically against the zombies. Peashooter can shoot a pea every second, Sunflower produces a Sun every few seconds, and Wallnut blocks zombies from moving forward until it is eaten.\n\nThe lawn mowers are a final line of defense that automatically trigger after zombies have reached the end of the lawn. Plan wisely – they can only be used once!\n\nEvery time a wave is announced, more zombies will appear within a short period of time. Prepare your attack and defense accordingly, especially for the final wave in the level.\n\nIf you defeat all the zombies in a given level, you may move on to the next level. If the zombies break into your home and eat your brains, the game is over.\n\n";
    fill(255);
    textSize(10); 
    textAlign(LEFT,TOP);
    text(description, width/2, height/2, width/2, height - 100);
    textAlign(LEFT,BOTTOM);
    text(instruct, width/2, height/2, width/2, height - 100);
    
    rectMode(CORNER);
    fill(0,0,255);
    noStroke();
    rect(width/2, 550, width/4, 50);
    fill(255);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("BACK", width/2, 550, width/4, 50);
   
  }
  
  public void inGameMenu(){
    
    fill(155,0,155);
    noStroke();
    rectMode(CORNER);
    rect(800, 10, 200, 50);
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("MENU", 800, 10, 200, 50);
    
    if (mousePressed && mouseX >= 800 && mouseX <= 1000 && mouseY >= 10 && mouseY <= 60){
      System.out.println("in game menu pressed");
      runGame = false; 
    }
  }
  
}
  
