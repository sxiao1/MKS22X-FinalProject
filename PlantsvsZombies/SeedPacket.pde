
// seed packet for each plant
class SeedPacket implements Displayable{
  float x,y,w,l;
  PImage image;
  SeedPacket(float xcor, float ycor, float wid, float len, PImage image){
    x = xcor;
    y = ycor;
    w = wid;
    l = len; 
    this.image = image;
  }
  
  void display(){
    rectMode(CORNER);
    fill(121,83,45);
    rect(x,y,w,l);
    image(image, x,y,w,l);
  }
 
 // check if seed packet has been clicked. 
 // return true if yes, return false otherwise
  boolean isClicked(){
    if (mousePressed && mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.l){
      return true;
    }
    return false;
  }
  
}
