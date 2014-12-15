
part of mane;


class Segment{
  int x_0;
  int y_0;
  int x_1;
  int y_1;
  int _x_c;
  int _y_c;
  bool cellUsed;
  Match match;
  
  Segment (this.x_0,this.y_0,this.x_1,this.y_1, this.cellUsed){
    _x_c=(x_1+x_0)~/2;
    _y_c=(y_1+y_0)~/2;
  }
  
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
  return true;
  }
  
  bool freeSegment(){
    cellUsed=false;
    match=null;
    return true;
  }
  
  String orientation(){
    if (x_1-x_0==0){
      if (y_1-y_0==0){
        return "point";
      }
      else{
        return "vertical";
      }
    }
    else{
      if (y_1-y_0==0){
        return "horizontal";
      }
      else{
        return "angle";
      }
    }
  }
  
  
  // Calculate distance between one point and the center of the segment
  int distanceToCenter(int x,int y){
       return(sqrt(pow(x-_x_c,2)+pow(y-_y_c,2))).toInt();     
  }
  
  String toString(){
   return "(Start: (${x_0},${y_0}) center: (${_x_c},${_y_c})) End: (${x_1},${y_1}))"; 
  }
  
  
}
//pour le jeux 2---------------------------------------------------------------------------


class Segment2{
  int x_0;
  int y_0;
  int x_1;
  int y_1;
  int _x_c;
  int _y_c;
  bool cellUsed;
  Match2 match2;
  
  Segment2 (this.x_0,this.y_0,this.x_1,this.y_1, this.cellUsed){
    _x_c=(x_1+x_0)~/2;
    _y_c=(y_1+y_0)~/2;
  }
  
  bool useSegement2(Match2 toSet){
    if (cellUsed==true){
      if (match2==toSet){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      match2=toSet;
      cellUsed=true;
    }
  return true;
  }
  
  bool freeSegment(){
    cellUsed=false;
    match2=null;
    return true;
  }
  
  String orientation(){
    if (x_1-x_0==0){
      if (y_1-y_0==0){
        return "point";
      }
      else{
        return "vertical";
      }
    }
    else{
      if (y_1-y_0==0){
        return "horizontal";
      }
      else{
        return "angle";
      }
    }
  }
  
  
  // Calculate distance between one point and the center of the segment
  int distanceToCenter(int x,int y){
       return(sqrt(pow(x-_x_c,2)+pow(y-_y_c,2))).toInt();     
  }
  
  String toString(){
   return "(Start: (${x_0},${y_0}) center: (${_x_c},${_y_c})) End: (${x_1},${y_1}))"; 
  }
  
  
}