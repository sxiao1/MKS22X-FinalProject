// Sun class, for the Sunflower class and also randomly generated suns
class Sun implements Moveable, Displayable{
  float x,y,ybound,speed;
  int sunCount;
  PImage sun;
  float angle;
  
  // takes in x- and y-coordinates and speed of movement 
  Sun(float xcor, float ycor, float ybound, float sunSpeed, PImage sunImage){
    x = xcor;
    y = ycor;
    angle = 0;
    this.ybound = ybound;
    speed = sunSpeed;
    sun = sunImage;
  }
  
  void display(){
    
    pushMatrix();//backup the original coordinate system
    //Change the coordinates for 
    //all objects then draw everything.
    //Draw all the things you want to draw
    //change the coordinates for JUST this one object
     translate(x,y);
     rotate(radians(angle));
     rect(-25,-25,50,50);
    image(sun,-25,-25,50,50);
    angle += 1;
    
     System.out.println("rotate angle: "+angle);
    popMatrix(); //restore the original coordinate system
  }
  
  void move(){
    if (y < ybound){
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


  // return amount of suns
  int getSun(){
    return sunCount;
  }
  
}
