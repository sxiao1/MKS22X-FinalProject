class Position implements Comparable<Position>{
  int row, numPlants;
  
  public Position(int row, int numPlants){
    this.row = row;
    this.numPlants = numPlants;
  }
  
 public int compareTo(Position other){
    return numPlants - other.numPlants;
 }
 
 public int getNum(){
   return numPlants;
 }
 
 public void setNum(int num){
   numPlants = num;
 }
  
}
