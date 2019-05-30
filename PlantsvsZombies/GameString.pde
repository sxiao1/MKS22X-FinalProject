// to display a string during the game
class GameString implements Displayable{
  String str;
  float x,y, fontSize;
  boolean display; // whether to display string or not
  
  GameString(String string, float xcor, float ycor, float size, boolean disp){
    str = string;
    x = xcor;
    y = ycor; 
    fontSize = size;
    display = disp;
  }
  
  public void display(){
    if (display){
      PFont f;
      f = createFont("Arial", fontSize,true);
      textFont(f,fontSize);
      textAlign(CENTER,BOTTOM);
      fill(255,0,0);
      text(str, x, y);
      
      // time frame for string to stay on the screen 
      if (frameCount % 180 == 60){
        display = false; 
      }
    }
  }
}
