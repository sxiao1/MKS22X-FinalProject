
// seed packet for each plant
class SeedPacket implements Displayable{
  float x,y,w,l;
  SeedPacket(float xcor, float ycor, float wid, float len){
    x = xcor;
    y = ycor;
    w = wid;
    l = len; 
  }
  
  void display(){
    fill(121,83,45);
    rect(x,y,w,l);
    if (isClicked() ){
      System.out.println("seed clicked");
    }
  }
 
 // check if seed packet has been clicked. 
 // return true if yes, return false otherwise
  boolean isClicked(){
    if (mousePressed && mouseX >= this.x && mouseX <= this.x + this.w && mouseY >= this.y && mouseY <= this.y + this.l){
      //fill(255);
      //rect(mouseX, mouseY, 50,50);
      return true;
    }
    return false;
  }
  
}
