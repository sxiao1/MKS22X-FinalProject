class EndString implements Displayable{
  String str;
  float x,y;
  EndString(String string, float xcor, float ycor){
    str = string;
    x = xcor;
    y = ycor;
  }
  public void display(){
      PFont f;
      f = createFont("Arial",70,true);
      textFont(f,25);
      textAlign(CENTER,BOTTOM);
      fill(255,0,0);
      text(str, x, y);
  }
}
