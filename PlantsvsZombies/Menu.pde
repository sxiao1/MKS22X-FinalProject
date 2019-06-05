class Menu{

  int option, x, y, page; 
  float mode, prevMode;
  PImage screen, startbg;
  
  public Menu(float mode, PImage startscreen, PImage startbg){
    this.mode = mode; // starting mode of the menu
    prevMode = 0; // keeps track of previous mode 
    // x, y coordinates, loads images
    x = width/2;
    y = height / 2;
    screen = startscreen;
    this.startbg = startbg;
    // default button option and page number of the instructions pages
    option = 0;
    page = 0;
  }
  
 
  public void display(){
    // START SCREEN
    if (mode == 0){
  
    image(startscreen, 0,0);
    startscreen.resize(1024, 600);
    image(startscreen, 0,0);

    }
    
    // MAIN MENU
    if (mode == 1){
      
      image(startbg, 0,0);
      startbg.resize(1024, 600);
      image(startbg, 0,0);
      
      rectMode(CENTER);
      noStroke();
      fill(100,75);
      
      rect(x,y, width/2, height - 100);
      fill(255);
      textSize(85); 
      textAlign(CENTER,CENTER);
      text("MAIN MENU", width/2, 100); 
      options(); 

    }
    
    // INSTRUCTIONS
    if (mode == 1.5){
      instructions(page);
     }
    
    // IN-GAME MENU BUTTON
     if (mode == 2){
         displayInGameMenu(); 
      }
    // IN-GAME MENU OPTIONS  
    if (mode == 2.5){
        options();
      }
      
    
  }
  
  // set mode to specified number
  public void setMode(int newMode){
    mode = newMode;
  }
  
  // display button options for main menu and in-game menu
  public void options(){
    
    fill(250,50);
    noStroke();
    rectMode(CENTER);
   
   // MAIN MENU
   if (mode == 1){ 
    //  START GAME, INSTRUCTIONS, QUIT 
    rect(x,height/3, width/2 - 100, 75);
    rect(x,height/3 + 110, width/2 - 100, 75); 
    rect(x,height/3 + 220, width/2 - 100, 75); 
    
      fill(255);
      textSize(25); 
      textAlign(CENTER,CENTER);
      text("START GAME", x, height/3);
      text("INSTRUCTIONS", x, height/3 + 110);
      text("QUIT", x, height/3 + 220);
    
   }
   
   // IN-GAME MENU OPTIONS 
   else if (mode == 2.5){

     // MENU BACKGROUND 
      rectMode(CENTER);
      noStroke();
      fill(100,75);
      rect(width/2, height/2, width/2, height);
      
      fill(255);
      textSize(70); 
      textAlign(CENTER,CENTER);
      text("MENU", width/2, 25);
      
    // MENU BUTTONS
    rectMode(CENTER);
    noStroke();
    fill(250,50);
    
     //  RESUME GAME, RESTART LEVEL, INSTRUCTIONS, MAIN MENU, QUIT 
      rect(x,height/6, width/2 - 100, 75);
      rect(x,height/6 + 110, width/2 - 100, 75);
      rect(x,height/6 + 220, width/2 - 100, 75); 
      rect(x,height/6 + 330, width/2 - 100, 75); 
      rect(x,height/6 + 440, width/2 - 100, 75); 
      
      textSize(25); 
      textAlign(CENTER,CENTER);
      fill(255);
      
      text("RESUME GAME", x, height/6);
      text("RESTART LEVEL", x, height/6 + 110);
      text("INSTRUCTIONS", x, height/6 + 220);
      text("MAIN MENU", x, height/6 + 330);
      text("QUIT", x, height/6 + 440);
    
   }
  }
  
  // display description and instructions 
  public void instructions(int pageNum){
    page = pageNum;
   
    rectMode(CENTER);
    noStroke();
    fill(100,75);
    rect(x,y, width/2, height);
    
    String description = "Plants vs. Zombies is tower defense game takes place in your front lawn, where you must defend your home against waves of zombies. You will use seed packets to plant a variety of plants that either attack or defend your house from zombies. You can purchase plants from an inventory bar at the top of the screen according to how many suns you collect throughout the game. Sun is grown by the sunflower plant, but it is also generated randomly throughout the game. Zombies walk slowly towards the house and must be shot down before they reach the plants, or else they will destroy the plants and eventually break into your home. The game ends when zombies enter the house and eat your brains.";
    String instruct = "At the start of the game, you are given 300 suns. Use them to plant a Peashooter, Sunflower, Walnut, or Cherry Bomb by clicking the appropriate seed packet and dropping the plant onto a plot of land. NOTE: You may only purchase a plant if you have enough Suns for it.\n\nCollect Suns that drop from the sky or Sunflower plants by clicking on them. Keep track of the number of Suns by looking at the sun counter on the top left corner of the screen.\n\nDefend your lawn by using your plants strategically against the zombies. Peashooter can shoot a pea every second, Sunflower produces a Sun every few seconds, Walnut blocks zombies from moving forward until it is eaten, and Cherry Bomb self-destructs, killing zombies in its vicinity.\n\nThe lawn mowers are a final line of defense that automatically trigger after zombies have reached the end of the lawn. Plan wisely – they can only be used once!\n\nEvery time a wave is announced, more zombies will appear within a short period of time. Prepare your attack and defense accordingly, especially for the final wave in the level.\n\nIf you defeat all the zombies in a given level, you may move on to the next level. If the zombies break into your home and eat your brains, the game is over.\n\n";
    String pageStr = "INSTRUCTIONS >>";
    
    // display description or instructions depending on the current page number 
    fill(255);
    textSize(15); 
    textAlign(LEFT,CENTER);
    if (page == 0){
    pageStr = "INSTRUCTIONS >>";
    text(description, width/2 + 15, height/2, width/2 - 60, height - 100);
    }
    else if (page == 1){
    pageStr = "<< DESCRIPTION";
    textSize(12); 
    text(instruct, width/2 + 15, height/2, width/2 - 60, height - 100);
    }
    
    rectMode(CORNER);
    fill(250,50);
    noStroke();
    
    // PAGE, BACK BUTTONS 
    rect(width/4, 550, width/4, 50);
    rect(width/2, 550, width/4, 50);
    
    fill(255);
    textSize(15); 
    textAlign(CENTER, CENTER);
    text(pageStr, width/4, 550, width/4, 50); 
    text("BACK", width/2, 550, width/4, 50);
   
  }

// ACTIVATED IF MOUSE IS CLICKED 
  public void act(){
    // FROM START SCREEN TO MAIN MENU 
    if (mode == 0){
      if (mouseX >= 315 && mouseX <= 715 && mouseY >= 530 && mouseY <= 575){
      mode = 1;   
      }
    }
    
    // MAIN MENU OPTIONS 
    if (mode == 1){
        float buttonCornerX = x - ((width/2 - 100)/2);
        float buttonWidth = width/2 - 100;
        float buttonCornerY = (height/3) - (75/2); 
        float buttonLength = 75; 
     
        if (mouseX >= buttonCornerX && mouseX <= buttonCornerX + buttonWidth){
          if (mouseY >= buttonCornerY && mouseY <= buttonCornerY + buttonLength + 110*2){
            option = (int)((mouseY - buttonCornerY) / 110) + 1;
          }
         // START GAME
          if (option == 1){
             mode = 2;
             option = 0; 
             runGame = true;
          }
          // INSTRUCTIONS
          else if (option == 2){
            mode = 1.5;
            prevMode = 1;
            option = 0; 
          }
          // QUIT
          else if (option == 3){
            option = 0; 
            runGame = false;
            exit();
          }
        }
      
    }
    // INSTRUCTIONS MODE
    if (mode == 1.5){
        if (mouseY >= 550 && mouseY <= 600){
          // SWITCH BETWEEN PAGES 0 AND 1
              if (mouseX >= width/4 && mouseX < width/2){
                option = 0; 
                if (page == 0){
                  page = 1;
                }
                else if (page == 1){
                  page = 0;
                }         
              }
              // EXIT INSTRUCTIONS PAGE
              else if (mouseX >= width/2 && mouseX <= 3*width/4){
              option = 0; 
              mode = prevMode;
              prevMode = 1.5;
              }
            }
    }  
    // MAIN MENU BUTTON OPENS UP MAIN MENU
    if (mode == 2){  
      option = 0; 
      if (mouseX >= 800 && mouseX <= 1000 && mouseY >= 10 && mouseY <= 60){
      mode = 2.5;
      runGame = false; 
     }
    }
    // MAIN MENU OPTIONS 
    if (mode == 2.5){
       runGame = false; 
       float buttonCornerX = x - ((width/2 - 100)/2);
       float buttonWidth = width/2 - 100;
       float buttonCornerY = (height/6) - (75/2); 
       float buttonLength = 75; 

          if (mouseX >= buttonCornerX && mouseX <= buttonCornerX + buttonWidth){
            if (mouseY >= buttonCornerY && mouseY <= buttonCornerY + buttonLength + 110*4){
            option = (int)((mouseY - (buttonCornerY)) / 110) + 1;
            }
          }
          // RESUME GAME  
          if (option == 1){
            mode = 2; 
            option = 0; 
            runGame = true; 
          }
          // NOTE: RESTART GAME IS NOT A WORKING FEATURE 
          
          // INSTRUCTIONS
          else if (option == 3){
            mode = 1.5;
            prevMode = 2.5;
            option = 0; 
          }
          // MAIN MENU
          else if (option == 4){
            mode = 1;
            option = 0; 
          }
          // QUIT 
          else if (option == 5){
            option = 0; 
            exit();
          }
        
    }
  }
  // DISPLAY THE IN-GAME MENU 
  public void displayInGameMenu(){
    
    rectMode(CORNER);
    noStroke();
    fill(100,75);
    rect(800, 10, 200, 50);
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("MENU", 800, 10, 200, 50);
  }
}
  
