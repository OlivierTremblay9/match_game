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
              matchesList.add(new Match(board, gridMatrix[7][6].x_0, gridMatrix[7][6].y_0, board.lengthMatches, board.widthMatches,gridMatrix[7][6].orientation(),gridMatrix[7][6],gridMatrix[7][6]));
              //print('Match 1 placed at: ${gridMatrix[1][0].x_0}, ${gridMatrix[1][0].y_0}, ${gridMatrix[1][0].orientation()}');
              //print('Match 2 placed at: ${gridMatrix[4][0].x_0}, ${gridMatrix[4][0].y_0}, ${gridMatrix[4][0].orientation()}'); 
              //print('Match 3 placed at: ${gridMatrix[1][2].x_0}, ${gridMatrix[1][2].y_0}, ${gridMatrix[1][2].orientation()}');
              
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
                secondSegment=gridMatrix[i][j+1];
                print('First index:[${i}][${j}], Second index:[${i}][${j+1}]');
              }
                  
              else{
                secondSegment=gridMatrix[i+2][j];
                print('First index:[${i}][${j}], Second index:[${i+2}][${j}]');
              }
                  
            }
          }
        }
   
    
    if (secondSegment!=null){
      if(firstSegment.cellUsed==false ){ // first Segment is free
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
        }
    
  }
  
  bool validate(){
    bool valueToreturn=false;
    switch (numberOfMatches){
       case 3: if(gridMatrix[1][0].cellUsed==true && gridMatrix[3][0].cellUsed==true && gridMatrix[4][0].cellUsed==true && gridMatrix[4][1].cellUsed==true && gridMatrix[3][1].cellUsed==true && gridMatrix[5][1].cellUsed==true){
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

//Memory board 2-------------------------------------------------------------------------------------------------------

class Memory_second {
  
  Board2 board2;
  List<List<Segment>> gridMatrix2; 
  int numberOfMatches;
  List<Match2>matchesList=new List();
  int displacements2;

  
  Memory_second(this.board2){
     
    gridMatrix2 = new List<List<Segment>>();
    
    // generates a segment matrix. All horizontal segments [0][k], and all vertical segements [1][k] 
    
    for(int i=board2.clearance;i<board2.height;i+=(board2.lengthMatches~/2)){
      List<Segment> rowH = new List<Segment>();
      List<Segment> rowV = new List<Segment>();
      for(int j=board2.clearance;j<board2.width;j+=(board2.lengthMatches~/2)){
        rowH.add(new Segment(j,i,j+board2.lengthMatches~/2,i,false));
        rowV.add(new Segment(j,i,j,i+board2.lengthMatches~/2,false));  
      }
      gridMatrix2.add(rowH);
      gridMatrix2.add(rowV);
    }
    
    
    //for(int k=0;k < gridMatrix2.length;k++) 
     //print(gridMatrix2[k]);
  }
  
  initGameStep(int numberOfMatchesIn){
    numberOfMatches=numberOfMatchesIn;
    matchesList.clear();
    for(int i=0;i<gridMatrix2.length;i++){
           for (int j=0;j< gridMatrix2[i].length;j++){
             gridMatrix2[i][j].freeSegment();
           }
    }
        
    switch (numberOfMatchesIn){
      case 3: print('4 matches game');
              displacements2=1;
              matchesList.add(new Match2(board2, gridMatrix2[4][2].x_0, gridMatrix2[4][2].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix2[4][2].orientation(),gridMatrix2[4][2],gridMatrix2[2][4]));
              matchesList.add(new Match2(board2, gridMatrix2[3][1].x_0, gridMatrix2[3][1].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix2[3][1].orientation(),gridMatrix2[3][1],gridMatrix2[3][2]));
              
              
              //print('Match 1 placed at: ${gridMatrix[1][0].x_0}, ${gridMatrix[1][0].y_0}, ${gridMatrix[1][0].orientation()}');
              //print('Match 2 placed at: ${gridMatrix[4][0].x_0}, ${gridMatrix[4][0].y_0}, ${gridMatrix[4][0].orientation()}'); 
              //print('Match 3 placed at: ${gridMatrix[1][2].x_0}, ${gridMatrix[1][2].y_0}, ${gridMatrix[1][2].orientation()}');
              
              break;
    }
    
  }

  draw(){
    for(int i=0;i<matchesList.length;i++){
      matchesList[i].draw(); 
    }
  }
  
  Match2 verifyIfSelectedMatch2click(int x, int y){
    Match2 activeMatch2=null;
    for (int i=0; i< matchesList.length ;i++){
               if (matchesList[i].intersects(x,y)==true){
                   activeMatch2=matchesList[i];
               }      
        }
    return activeMatch2;
  }
  
  Segment nearestSegment(int x,int y){
    
    Segment nearest=gridMatrix2[0][0];
    int distance=gridMatrix2[0][0].distanceToCenter(x, y);
    
    for(int i=0;i<gridMatrix2.length;i++){
      for (int j=0;j< gridMatrix2[i].length;j++){
        if (distance >gridMatrix2[i][j].distanceToCenter(x, y)){
          nearest=gridMatrix2[i][j];
          distance=gridMatrix2[i][j].distanceToCenter(x, y);
        }
      }
    }
    return nearest;
  }
  
  bool moveMatch2(Match2 activeMatch2, Segment firstSegment){    
    Segment secondSegment=null;
    // we need to locate the second segment to be used because 1 match occupies 2 segments
    for(int i=0;i<gridMatrix2.length;i++){
          for (int j=0;j< gridMatrix2[i].length;j++){
            if (gridMatrix2[i][j]==firstSegment){
              if (firstSegment.orientation()=='horizontal'){
                secondSegment=gridMatrix2[i][j+1];
                print('First index:[${i}][${j}], Second index:[${i}][${j+1}]');
              }
                  
              else{
                secondSegment=gridMatrix2[i+2][j];
                print('First index:[${i}][${j}], Second index:[${i+2}][${j}]');
              }
                  
            }
          }
        }
   
    
    if (secondSegment!=null){
      if(firstSegment.cellUsed==false ){ // first Segment is free
        if (secondSegment.cellUsed==false || secondSegment.match==activeMatch2){ //Second segment is free or is occupied by the same Match
          activeMatch2.used1.freeSegment();
          activeMatch2.used2.freeSegment();
          activeMatch2.setOnSegments(firstSegment,secondSegment);
          activeMatch2.setPosDraw(activeMatch2.posX2, activeMatch2.posY2, activeMatch2.orientation);
          displacements2--;
          return true;
        }
      }
    }
    return false;
  }
  
  solve(){
    matchesList.clear();
    for(int i=0;i<gridMatrix2.length;i++){
        for (int j=0;j< gridMatrix2[i].length;j++){
                 gridMatrix2[i][j].freeSegment();
        }
    }
    switch (numberOfMatches){
          case 3: print('4 matches game solution');
                        matchesList.add(new Match2(board2, gridMatrix2[1][0].x_0, gridMatrix2[1][0].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix2[1][0].orientation(),gridMatrix2[1][0],gridMatrix2[3][0]));
                        matchesList.add(new Match2(board2, gridMatrix2[4][0].x_0, gridMatrix2[4][0].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix2[4][0].orientation(),gridMatrix2[4][0],gridMatrix2[4][1]));
                        matchesList.add(new Match2(board2, gridMatrix2[3][1].x_0, gridMatrix2[3][1].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix2[3][1].orientation(),gridMatrix2[3][1],gridMatrix2[5][1]));
                        //matchesList.add(new Match2(board2, gridMatrix[3][1].x_0, gridMatrix[3][1].y_0, board2.lengthMatches, board2.widthMatches,gridMatrix[3][1].orientation(),gridMatrix[3][1],gridMatrix[5][1]));
                  break;
        }
    
  }
  
  bool validate2(){
    bool valueToreturn=false;
    switch (numberOfMatches){
       case 3: if(gridMatrix2[1][0].cellUsed==true && gridMatrix2[3][0].cellUsed==true && gridMatrix2[4][0].cellUsed==true && gridMatrix2[4][1].cellUsed==true && gridMatrix2[3][1].cellUsed==true && gridMatrix2[5][1].cellUsed==true){
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

