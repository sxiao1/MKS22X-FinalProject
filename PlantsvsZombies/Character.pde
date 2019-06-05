// parent class of plants and zombies 
abstract class Character implements Damageable, Displayable, Collideable{
  float x,y,w,l,HP,damage;
  PImage character;
  
  Character(float xcor,float ycor,float wid,float len,float dam, float HPnum, PImage image){
    x = xcor;
    y = ycor;
    w = wid;
    l = len;
    HP = HPnum;
    damage = dam;
    character = image;
  }
  
  // accessor methods
   float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  float getW(){
    return w;
  }
  float getL(){
    return l;
  }
  float getHP(){
    return HP;
  }
  float getDamage(){
    return damage;
  }
  PImage getImage(){
    return character;
  }
  void setHP(int newHP){
    HP = newHP;
  }
  
  // when attacked by another character
  void takeHit(float dam){
    this.HP -= dam;
  }
  
  // attack method to be coded in subclasses
  abstract void attack(Character c);
  
  void display(){
    image(character,x,y, w,l);
  }
  
  // to be coded in subclasses
  abstract boolean isTouching(Character other);
  
  }
