class Menu{

  int mode, x, y; 
  PImage screen;
  
  public Menu(int mode, PImage startscreen){
    this.mode = mode;
    x = width/2;
    y = height / 2;
    screen = startscreen;
  }
  
  public void display(){
    // START SCREEN
    if (mode == 0){
     
      // make the menu
      //fill(255);
      
      //rect(0,0, width, height);
    image(startscreen, 0,0);
    startscreen.resize(1024, 600);
    image(startscreen, 0,0);
    rectMode(CORNER);
    fill(155,0,155);
    rect(315, 530, 400, 45); 
    }
    
    if (mousePressed && mouseX >= 315 && mouseX <= 715 && mouseY >= 530 && mouseY <= 575){
      mode = 1;
      System.out.println("CLICK HERE TO START IS PRESSED");
      fill(255);
      rect(0,0,width, height);
      rectMode(CENTER);
      // magenta
      fill(155,0,155);
      noStroke();
      rect(x,y, width/2, height - 100);
      fill(255);
      textSize(85); 
      textAlign(CENTER,CENTER);
      text("MAIN MENU", width/2, 100);
     
      options();    
     }
     
    if (mousePressed){
        float xCorner = x - ((width/2 - 100)/2);
        float xWidth = width/2 - 100;
        float yCorner = (height/3) - (75/2); 
        float yLength = 75; 
        //System.out.println("MOUSE PRESSED");
        if (mouseX >= xCorner && mouseX <= xCorner + xWidth){
         // System.out.println("In width range");
         // START GAME
          if (mouseY >= yCorner && mouseY <= yCorner + yLength){
             System.out.println("START");
             runGame = true;
          }
          else if (mouseY > yCorner + 110 && mouseY <= yCorner + yLength + 110){
            System.out.println("INSTRUCTIONS");
            instructions();
          }
          else if (mouseY > yCorner + 220 && mouseY <= yCorner + yLength + 220){
            System.out.println("QUIT GAME");
            runGame = false;
            exit();
          }
        }
      }
      
    }
  
  public void setMode(int newMode){
    mode = newMode;
  }
  
  public void options(){
    fill(0,0,255);
    noStroke();
    rectMode(CENTER);
    
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
  
  public void instructions(){
    fill(255);
      rect(0,0,width, height);
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
  }
  
}
  
