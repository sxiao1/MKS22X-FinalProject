
// sun counter 
class SunCount implements Displayable{
  float x,y,w,l;
  int count;
  PImage sun;
  PFont f;
  
  SunCount(float xcor,float ycor,float wid,float len, int counter, PImage sunImg){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    count = counter;
    sun = sunImg;
  }
  
  // update the number of suns collected
  void display(){
    noStroke();
    fill(121,83,45);
    rect(x,y,w,l);
    fill(212,190,145);
    rect(x + x/10, y + (2*l/3), w - x/5, l - 70);
    image(sun,x+12,y,50,50);
    f = createFont("Arial",70,true);
    textFont(f,25);
    textAlign(CENTER,BOTTOM);
    fill(0);
    for(int i = 0; i < listOfSuns.size(); i++){
      if(listOfSuns.get(i).collected()){
        count+=25;
        listOfSuns.remove(i);
      }
    }
    text(count,x + w/2, y + l);
    stroke(0);
  }
  
  // accessor method to get count 
  int getCount(){
    return count;
  }
  // change sun count to specified number
  void setCount(int sunNum){
    count = sunNum;
  }
}
