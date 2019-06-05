// Sun class, for the Sunflower class and also randomly generated suns
class Sun implements Moveable, Displayable{
  
  float  x,y,ybound,speed;
  PImage sun;
  
  float angle; // of rotation
  // for parabolic movement to sun counter
  float beginX, beginY, distX, distY, endX, endY;
  float step;
  float percent;
  // whether sun has been clicked
  boolean collected;
  
  // takes in x- and y-coordinates and speed of movement, as well as boundary (when to stop moving)
  Sun(float xcor, float ycor, float ybound, float sunSpeed, PImage sunImage){
    x = xcor;
    y = ycor;
    
    endX = 112;
    endY = 10;
    percent = 0.0;
    step = 0.01;
    angle = 0;
    
    this.ybound = ybound;
    
    speed = sunSpeed;
    sun = sunImage;
  }
  
  void display(){
    if (!collected){
     // rotate sun as it moves
     pushMatrix();
     translate(x,y);
     rotate(radians(angle));
     image(sun,-25,-25,50,50);
     angle += 1;
     popMatrix(); 
    }
    // if sun has been clicked, don't rotate the sun
    else{
      image(sun,x,y,50,50);
    }
  }
  
  void move(){
    // move sun downward if it hasn't been collected
    if (!collected && y < ybound){
      y += speed;
    }
    // if sun has been collected, move the sun towards the sun counter
    else if (collected ){
      percent += step; 
      if (percent < 1.0){
        x = beginX + percent * distX;
        y = beginY + pow(percent,2) * distY;
      }
      // remove sun once it reaches the sun counter
      if (percent >= 1.0){
      thingsToDisplay.remove(this);
      thingsToMove.remove(this);
     }    
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
  
}
