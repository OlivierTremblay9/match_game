part of mane;

class GameCtrl{
  Board board;
  int gameState;
  int numOfMovesAvailables;
  int numOfMovesDone;
  List<int> numOfTriesByStep;
  
  GameCtrl(this.board){
    gameState=0;
    numOfMovesAvailables=1;
    numOfMovesDone=0;
    numOfTriesByStep=new List();
    numOfTriesByStep.add(0);
    numOfTriesByStep.add(0);
    numOfTriesByStep.add(0);
    board.gameSpace.initGameStep(3);
  }
  
  void matchMovedOk (){
    numOfMovesAvailables--;
    numOfMovesDone++;
    if(numOfMovesAvailables==0 && gameState==0){            // No more moves left first step
      numOfTriesByStep[0]++;
      if(board.gameSpace.validate()==true){                 // if success
        gameState=2;                                        // gameState =2 means success and go to the next step
      }
      else{
        gameState=1;                                        // gameState =1 means fail and restart
      }
    }
    else{
      if (numOfMovesAvailables==0 && gameState==4){
        numOfTriesByStep[1]++;
        if(board.gameSpace.validate()==true){                 // if success
          gameState=6;                                        // gameState =6 means success and go to the next step
        }
        else{
          gameState=5;                                        // gameState =5 means fail and restart
        } 
      }
      else{
        if (numOfMovesAvailables==0 && gameState==8){
          numOfTriesByStep[2]++;
          if(board.gameSpace.validate()==true){                 // if success
             gameState=10;                                        // gameState =10 means success and go to the next step
           }
          else{
             gameState=9;                                        // gameState =9 means fail and restart
          }
        }
      }
    }
  }
  
  void nextStep(){
    numOfMovesDone=0;
    switch (gameState){
      case 1: gameState=0;                                    // 3 match fail so restart               
              board.gameSpace.initGameStep(3);
              numOfMovesAvailables=1;
              break;
      case 2: gameState=4;                                    // Success go to 12 match
              board.gameSpace.initGameStep(12);
              numOfMovesAvailables=5;
              break;
      case 3: gameState=0;                                    // Solve so go to 3 match
              board.gameSpace.initGameStep(3);
              numOfMovesAvailables=1;
              break;
      case 5: gameState=4;
              board.gameSpace.initGameStep(12);
              numOfMovesAvailables=5;
              break;
      case 6: gameState=8; 
              board.gameSpace.initGameStep(16); // modified
              numOfMovesAvailables=1;
              break;
      case 7: gameState=4;
              board.gameSpace.initGameStep(12);
              numOfMovesAvailables=5;
              break;
      case 9: gameState=8;
              board.gameSpace.initGameStep(16);
              numOfMovesAvailables=1;
              break;
      case 10:gameState=0;
              board.gameSpace.initGameStep(3);
              numOfMovesAvailables=1;
              break;
      case 11:gameState=8;
              board.gameSpace.initGameStep(16);
              numOfMovesAvailables=1;
              break;
       
    }
  }
  void solve(){
    switch (gameState){
      case 0:   gameState=3;
                board.gameSpace.solve();
                break;
      case 1:   gameState=3;
                board.gameSpace.solve();
                break;
      case 2:   gameState=2;
                break;
      case 3:   gameState=3;
                break;
      case 4:   gameState=7;
                board.gameSpace.solve();
                break;
      case 5:   gameState=7;
                board.gameSpace.solve();
                break;
      case 6:   gameState=6;
                break;
      case 7:   gameState=7;
                break;              
      case 8:   gameState=11;
                board.gameSpace.solve();
                break;
      case 9:   gameState=11;
                board.gameSpace.solve();
                break;
      case 10:  gameState=10;
                break;
      case 11:  gameState=11;
                break;
    }
    
  }
}