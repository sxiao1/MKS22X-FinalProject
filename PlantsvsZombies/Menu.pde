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
      
      image(screen,1024,600);
      
      rectMode(CENTER);
      // magenta
      fill(155,0,155);
      noStroke();
      rect(x,y, width/2, height - 100);
      fill(255);
      textSize(100); 
      textAlign(CENTER,CENTER);
      text("MAIN MENU", width/2, 100);
      
      fill(0,155,0);
      
      
    }
  
  }
  
  public void setMode(int newMode){
    mode = newMode;
  }
  
  public void options(){
    
  }
  
}
