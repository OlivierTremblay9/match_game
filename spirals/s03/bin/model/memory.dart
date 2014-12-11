part of mane;

class Memory {
  
  Board board;
  List<List<Segment>> gridMatrix; 
  int numberOfMatches;

  
  Memory(this.board,this.numberOfMatches){
     
    gridMatrix = new List<List<Segment>>();
    
    for(int i=board.clearance;i<board.height;i+=(board.lengthMatches~/2)){
      List<Segment> row = new List<Segment>();
      for(int j=board.clearance;j<board.width;j+=(board.lengthMatches~/2)){
        row.add(new Segment(i,j,i,j+board.lengthMatches~/2,false));  
      }
      gridMatrix.add(row);
    }
    
    
//    for(int k=0;k < gridMatrix.length;k++) 
//      print(gridMatrix[k]);
  }

}

class Segment{
  int x_0;
  int y_0;
  int x_1;
  int y_1;
  bool cellUsed;
  Match match;
  
  Segment (this.x_0,this.y_0,this.x_1,this.y_1, this.cellUsed);
  
  bool useSegement(Match toSet){
    if (cellUsed==true){
      if (match==toSet){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      match=toSet;
      cellUsed=true;
    }
  return false;
  }
  
  bool freeSegment(){
    cellUsed=false;
    match=null;
    return true;
  }
  
  String orientation(){
    if (x_1-x_0==0){
      if (y_1-y_1==0){
        return "point";
      }
      else{
        return "horizontal";
      }
    }
    else{
      if (y_1-y_1==0){
        return "vertical";
      }
      else{
        return "angle";
      }
    }
  }
  
  String toString(){
   return "(${x_0},${y_0}) (${x_1},${y_1})"; 
  }
  
}