part of mane;

class Memory {
  
  Board board;
  List<List<Segment>> gridMatrix; 
  int numberOfMatches;
  List<Match>matchesList=new List();
  int displacements;

  
  Memory(this.board){
     
    gridMatrix = new List<List<Segment>>();
    
    // generates a segment matrix. All horizontal segments [0][k], and all vertical segements [1][k] 
    
    for(int i=board.clearance;i<board.height;i+=(board.lengthMatches~/2)){
      List<Segment> rowH = new List<Segment>();
      List<Segment> rowV = new List<Segment>();
      for(int j=board.clearance;j<board.width;j+=(board.lengthMatches~/2)){
        rowH.add(new Segment(j,i,j+board.lengthMatches~/2,i,false));
        rowV.add(new Segment(j,i,j,i+board.lengthMatches~/2,false));  
      }
      gridMatrix.add(rowH);
      gridMatrix.add(rowV);
    }
    
    
    //for(int k=0;k < gridMatrix.length;k++) 
     //print(gridMatrix[k]);
  }
  
  initGameStep(int numberOfMatchesIn){
    numberOfMatches=numberOfMatchesIn;
    matchesList.clear();
    for(int i=0;i<gridMatrix.length;i++){
           for (int j=0;j< gridMatrix[i].length;j++){
             gridMatrix[i][j].freeSegment();
           }
    }
        
    switch (numberOfMatchesIn){
      
      case 3: print('3 matches game');
                    displacements=1;
                    matchesList.add(new Match(board, gridMatrix[1][0].x_0, gridMatrix[1][0].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][0].orientation(),gridMatrix[1][0],gridMatrix[3][0]));
                    matchesList.add(new Match(board, gridMatrix[4][0].x_0, gridMatrix[4][0].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][0].orientation(),gridMatrix[4][0],gridMatrix[4][1]));
                    matchesList.add(new Match(board, gridMatrix[1][2].x_0, gridMatrix[1][2].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][2].orientation(),gridMatrix[1][2],gridMatrix[3][2]));
           
                    break;
                    
      case 12: print('12 matches game');
              displacements=5;
              matchesList.add(new Match(board, gridMatrix[1][6].x_0, gridMatrix[1][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][6].orientation(),gridMatrix[1][6],gridMatrix[3][6]));
              matchesList.add(new Match(board, gridMatrix[4][6].x_0, gridMatrix[4][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][6].orientation(),gridMatrix[4][6],gridMatrix[4][7]));
              matchesList.add(new Match(board, gridMatrix[4][4].x_0, gridMatrix[4][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][4].orientation(),gridMatrix[4][4],gridMatrix[4][5]));
              matchesList.add(new Match(board, gridMatrix[5][6].x_0, gridMatrix[5][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[5][6].orientation(),gridMatrix[5][6],gridMatrix[7][6]));
              matchesList.add(new Match(board, gridMatrix[8][4].x_0, gridMatrix[8][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[8][4].orientation(),gridMatrix[8][4],gridMatrix[8][5]));
              matchesList.add(new Match(board, gridMatrix[8][6].x_0, gridMatrix[8][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[8][6].orientation(),gridMatrix[8][6],gridMatrix[8][7]));
              matchesList.add(new Match(board, gridMatrix[9][8].x_0, gridMatrix[9][8].y_0, board.lengthMatches, board.widthMatches,gridMatrix[9][8].orientation(),gridMatrix[9][8],gridMatrix[11][8]));
              matchesList.add(new Match(board, gridMatrix[13][8].x_0, gridMatrix[13][8].y_0, board.lengthMatches, board.widthMatches,gridMatrix[13][8].orientation(),gridMatrix[13][8],gridMatrix[15][8]));
              matchesList.add(new Match(board, gridMatrix[9][4].x_0, gridMatrix[9][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[9][4].orientation(),gridMatrix[9][4],gridMatrix[11][4]));
              matchesList.add(new Match(board, gridMatrix[13][4].x_0, gridMatrix[13][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[13][4].orientation(),gridMatrix[13][4],gridMatrix[15][4]));
              matchesList.add(new Match(board, gridMatrix[16][4].x_0, gridMatrix[16][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[16][4].orientation(),gridMatrix[16][4],gridMatrix[16][5]));
              matchesList.add(new Match(board, gridMatrix[16][6].x_0, gridMatrix[16][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[16][6].orientation(),gridMatrix[16][6],gridMatrix[16][7]));
     
              
              break;
              
    }
    
  }

  draw(){
    for(int i=0;i<matchesList.length;i++){
      matchesList[i].draw(); 
    }
  }
  
  Match verifyIfSelectedMatchclick(int x, int y){
    Match activeMatch=null;
    for (int i=0; i< matchesList.length ;i++){
               if (matchesList[i].intersects(x,y)==true){
                   activeMatch=matchesList[i];
               }      
        }
    return activeMatch;
  }
  
  Segment nearestSegment(int x,int y){
    
    Segment nearest=gridMatrix[0][0];
    int distance=gridMatrix[0][0].distanceToCenter(x, y);
    
    for(int i=0;i<gridMatrix.length;i++){
      for (int j=0;j< gridMatrix[i].length;j++){
        if (distance >gridMatrix[i][j].distanceToCenter(x, y)){
          nearest=gridMatrix[i][j];
          distance=gridMatrix[i][j].distanceToCenter(x, y);
        }
      }
    }
    return nearest;
  }
  
  bool moveMatch(Match activeMatch, Segment firstSegment){    
    Segment secondSegment=null;
    // we need to locate the second segment to be used because 1 match occupies 2 segments
    for(int i=0;i<gridMatrix.length;i++){
          for (int j=0;j< gridMatrix[i].length;j++){
            if (gridMatrix[i][j]==firstSegment){
              if (firstSegment.orientation()=='horizontal'){
                if(j+1<gridMatrix[i].length)
                  secondSegment=gridMatrix[i][j+1];
                //print('First index:[${i}][${j}], Second index:[${i}][${j+1}]');
              }
                  
              else{
                if(i+2<gridMatrix.length)
                  secondSegment=gridMatrix[i+2][j];
                //print('First index:[${i}][${j}], Second index:[${i+2}][${j}]');
              }
                  
            }
          }
        }
   
    
    if (secondSegment!=null){
      if(firstSegment.cellUsed==false || firstSegment.match==activeMatch ){ // first Segment is free or same match
        if (secondSegment.cellUsed==false || secondSegment.match==activeMatch){ //Second segment is free or is occupied by the same Match
          activeMatch.used1.freeSegment();
          activeMatch.used2.freeSegment();
          activeMatch.setOnSegments(firstSegment,secondSegment);
          activeMatch.setPosDraw(activeMatch.posX, activeMatch.posY, activeMatch.orientation);
          displacements--;
          return true;
        }
      }
    }
    return false;
  }
  
  solve(){
    matchesList.clear();
    for(int i=0;i<gridMatrix.length;i++){
        for (int j=0;j< gridMatrix[i].length;j++){
                 gridMatrix[i][j].freeSegment();
        }
    }
    switch (numberOfMatches){
      
      case 3: print('3 matches game solution');
                             matchesList.add(new Match(board, gridMatrix[1][0].x_0, gridMatrix[1][0].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][0].orientation(),gridMatrix[1][0],gridMatrix[3][0]));
                             matchesList.add(new Match(board, gridMatrix[4][0].x_0, gridMatrix[4][0].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][0].orientation(),gridMatrix[4][0],gridMatrix[4][1]));
                             matchesList.add(new Match(board, gridMatrix[3][1].x_0, gridMatrix[3][1].y_0, board.lengthMatches, board.widthMatches,gridMatrix[3][1].orientation(),gridMatrix[3][1],gridMatrix[5][1]));

                       break;

      case 12:      print('12 matches game solution');
        
                    matchesList.add(new Match(board, gridMatrix[1][6].x_0, gridMatrix[1][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][6].orientation(),gridMatrix[1][6],gridMatrix[3][6]));
                    matchesList.add(new Match(board, gridMatrix[4][6].x_0, gridMatrix[4][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][6].orientation(),gridMatrix[4][6],gridMatrix[4][7]));
                    matchesList.add(new Match(board, gridMatrix[4][4].x_0, gridMatrix[4][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[4][4].orientation(),gridMatrix[4][4],gridMatrix[4][5]));
                    matchesList.add(new Match(board, gridMatrix[5][6].x_0, gridMatrix[5][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[5][6].orientation(),gridMatrix[5][6],gridMatrix[7][6]));
                    matchesList.add(new Match(board, gridMatrix[8][4].x_0, gridMatrix[8][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[8][4].orientation(),gridMatrix[8][4],gridMatrix[8][5]));
                    matchesList.add(new Match(board, gridMatrix[8][6].x_0, gridMatrix[8][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[8][6].orientation(),gridMatrix[8][6],gridMatrix[8][7]));
                    matchesList.add(new Match(board, gridMatrix[9][6].x_0, gridMatrix[9][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[9][6].orientation(),gridMatrix[9][6],gridMatrix[11][6]));       
                    matchesList.add(new Match(board, gridMatrix[1][4].x_0, gridMatrix[1][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[1][4].orientation(),gridMatrix[1][4],gridMatrix[3][4]));
                    matchesList.add(new Match(board, gridMatrix[9][4].x_0, gridMatrix[9][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[9][4].orientation(),gridMatrix[9][4],gridMatrix[11][4])); 
                    matchesList.add(new Match(board, gridMatrix[5][8].x_0, gridMatrix[5][8].y_0, board.lengthMatches, board.widthMatches,gridMatrix[5][8].orientation(),gridMatrix[5][8],gridMatrix[7][8]));
                    matchesList.add(new Match(board, gridMatrix[12][4].x_0, gridMatrix[12][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[12][4].orientation(),gridMatrix[12][4],gridMatrix[12][5]));
                    matchesList.add(new Match(board, gridMatrix[0][4].x_0, gridMatrix[0][4].y_0, board.lengthMatches, board.widthMatches,gridMatrix[0][4].orientation(),gridMatrix[0][4],gridMatrix[0][5]));                                                                             
                  break;
       
        }
    
  }
  
  bool validate(){
    bool valueToreturn=false;
    switch (numberOfMatches){
      case 3:       if( gridMatrix[1][0].cellUsed==true && gridMatrix[3][0].cellUsed==true &&
                        gridMatrix[4][0].cellUsed==true && gridMatrix[4][1].cellUsed==true && 
                        gridMatrix[3][1].cellUsed==true && gridMatrix[5][1].cellUsed==true    ){
                       valueToreturn=true;
                     }
                     else{
                       valueToreturn=false;
                      }
                      break;
      
      case 12: if ( gridMatrix[1][6].cellUsed==true && gridMatrix[3][6].cellUsed==true &&
                    gridMatrix[4][6].cellUsed==true && gridMatrix[4][7].cellUsed==true && 
                    gridMatrix[4][4].cellUsed==true && gridMatrix[4][5].cellUsed==true &&
                    gridMatrix[5][6].cellUsed==true && gridMatrix[7][6].cellUsed==true &&
                    gridMatrix[8][4].cellUsed==true && gridMatrix[8][5].cellUsed==true &&
                    gridMatrix[8][6].cellUsed==true && gridMatrix[8][7].cellUsed==true &&
                    gridMatrix[9][6].cellUsed==true && gridMatrix[11][6].cellUsed==true &&
                    gridMatrix[1][4].cellUsed==true && gridMatrix[3][4].cellUsed==true &&
                    gridMatrix[9][4].cellUsed==true && gridMatrix[11][4].cellUsed==true &&
                    gridMatrix[5][8].cellUsed==true && gridMatrix[7][8].cellUsed==true &&
                    gridMatrix[12][4].cellUsed==true && gridMatrix[12][5].cellUsed==true &&
                    gridMatrix[0][4].cellUsed==true && gridMatrix[0][5].cellUsed==true ){
                  valueToreturn=true;        
                }
                else{
                  valueToreturn=false; 
                }
                break;
        
    }
    
    return valueToreturn;
  }
  
}

