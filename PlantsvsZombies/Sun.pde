// Sun class, for the Sunflower class and also randomly generated suns
class Sun implements Moveable, Displayable{
  float beginX,beginY,x,y,ybound,speed;
  int sunCount;
  PImage sun;
  float angle;
  float distX, distY, endX, endY;
  float step = 0.01;
  float percent = 0.0;
  boolean collected;
  
  // takes in x- and y-coordinates and speed of movement 
  Sun(float xcor, float ycor, float ybound, float sunSpeed, PImage sunImage){
    x = xcor;
    y = ycor;
    endX = 112;
    endY = 10;
    
    angle = 0;
    this.ybound = ybound;
    speed = sunSpeed;
    sun = sunImage;
  }
  
  void display(){
    if (!collected){
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
    else{
      image(sun,x,y,50,50);
    }
  }
  
  void move(){
    if (!collected && y < ybound){
      y += speed;
    }
    
    else if (collected ){
      percent += step; 
      if (percent < 1.0){
        x = beginX + percent * distX;
        y = beginY + pow(percent,2) * distY;
      }
      if (x == endX && y == endY){
      sunCount++;
      thingsToDisplay.remove(this);
      thingsToMove.remove(this);
     }
      // suncount sun is at 90, 170
      
      System.out.println("sun has been clicked");
      
    }
  }
  
  // if the user clicks on the sun, then it has been collected 
  boolean collected(){
    if (mousePressed && mouseX >= this.x && mouseX <= this.x + 50 && mouseY >= this.y && mouseY <= this.y + 50){
      collected = true;
    beginX = x;
    beginY = y;
    distX = endX - beginX;
    distY = endY - beginY;
      return true;
    }
    return false;
  }


  // return amount of suns
  int getSun(){
    return sunCount;
  }
  
}
