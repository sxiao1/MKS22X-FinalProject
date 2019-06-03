// to display a string during the game
class GameString implements Displayable{
  String str;
  float x,y, fontSize, sec;
  boolean display; // whether to display string or not
  
  GameString(String string, float xcor, float ycor, float size, boolean disp){
    str = string;
    x = xcor;
    y = ycor; 
    fontSize = size;
    display = disp;
    sec = 5; // number of seconds to zoom in 
  }
  
  public void display(){
    if (display){
      PFont f;
      f = createFont("Arial", fontSize,true);
      textFont(f,fontSize * sec);
      textAlign(CENTER,BOTTOM);
      fill(255,0,0);
      text(str, x, y);
      // time frame for string to stay on the screen 
      if (frameCount % 2 == 0){
        sec -= 0.15;
      }
      if (frameCount % 1000 == 60){
        display = false; 
      }
    }
  }
}
