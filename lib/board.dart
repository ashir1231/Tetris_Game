import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';



List<List<Tetromino?>> gameBoard= List.generate(
  colLength,
      (i) => List.generate(
  rowLength,
    (j)=>null,
  ),
);
class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  ///Current tetris piece
  Piece currentPiece = Piece(type: Tetromino.I);
  int currentScore=0;
  bool gameOver=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///Start Game when app starts
    startGame();
  }
  void startGame(){
    currentPiece.intializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate){
    Timer.periodic(frameRate, (timer) {

      setState(() {
        clearLines();
        ///check for landing
        checkLanding();

        if(gameOver==true){
          timer.cancel();
          showGameOverDialoge();
        }
        ///move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }
///game over dialog

void  showGameOverDialoge(){
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
      title: Text('Game Over'),
        content: Text('your score is $currentScore'),
        actions: [
          TextButton(onPressed: (){
            resetGame();
            Navigator.pop(context);
          }, child: Text('Play Again'),),
        ],
    ),

    );
}
  ///

  void resetGame(){
    ///reset the game board
    gameBoard= List.generate(
      colLength,
          (i) => List.generate(
        rowLength,
            (j)=>null,
      ),
    );

    ///new game
    gameOver=false;
    currentScore=0;

    ///create a new piece
    createNewPiece();

    ///start a game
    startGame();

  }

  ///check for collision in a future position
  ///return true-> there is a collision
  ///return false-> there is no collision
  bool checkCollision(Direction direction){
    // loop through each position
    for(int i=0; i<currentPiece.position.length; i++)
      {
        ///calculate the row and column of current position
        int row= (currentPiece.position[i]/rowLength).floor();
        int col= currentPiece.position[i] % rowLength;


    ///adjust row and column based on the direction
    if(direction== Direction.left){
      col -=1;
    }
    if(direction== Direction.right){
          col +=1;
        }
    if(direction== Direction.down){
          row +=1;
        }
    ///check if piece is out of bounds (either too low or too far to the left or right)
    if(row>=colLength || col<0 || col>=rowLength){
      return true;
    }

    }

    ///If no collision detected return false
    return false;
  }

  void checkLanding(){
    ///if going down is occupied
    if(checkCollision(Direction.down)|| checkLanded()){

      for(int i=0; i<currentPiece.position.length; i++){

        int row= (currentPiece.position[i]/rowLength).floor();
        int col= currentPiece.position[i] % rowLength;
        if(row>=0 && col>=0){

          gameBoard[row][col]= currentPiece.type;

        }
      }
      ///once landed create a new piece
      createNewPiece();
    }
  }

  bool checkLanded() {
    /// loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      /// check if the cell below is already occupied
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; /// collision with a landed piece
      }
    }

    return false; /// no collision with landed pieces
  }
void createNewPiece(){
    ///create a random object to generate a random tetromino type

  Random rand= Random();

  ///create a new piece with random type
  Tetromino randomType= Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentPiece= Piece(type: randomType);
  currentPiece.intializePiece();

  if(isGameOver()){
    gameOver=true;
  }
}

void moveLeft(){
if(!checkCollision(Direction.left)){
  setState(() {
    currentPiece.movePiece(Direction.left);
  });
}
}
void moveRight(){
  if(!checkCollision(Direction.right)){
    setState(() {
      currentPiece.movePiece(Direction.right);
    });
  }
}
void rotatePiece(){
setState(() {
  currentPiece.rotatePiece();
});
}
void clearLines(){
    for(int row = colLength - 1; row>=0; row--){
      bool rowIsFull = true;

      for(int col=0; col<rowLength; col++){
        if(gameBoard[row][col]==null){
          rowIsFull = false;
          break;
        }
      }
      if(rowIsFull){
        for(int r = row; r>0; r--){
          gameBoard[r] = List.from(gameBoard[r-1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
}

///Game over method
  bool isGameOver(){
    for(int col = 0; col<rowLength; col++){
      if(gameBoard[0][col]!=null){
        return true;

      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength*colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength),
                itemBuilder: (context,index) {

                  ///get row and column of each index
                  int row= (index/rowLength).floor();
                  int col= index % rowLength;
                  if(currentPiece.position.contains(index)){
                    return Pixel(
                      color: currentPiece.color,

                    );
                  }
                  else if(gameBoard[row][col] !=null ){
                    final Tetromino? tetrominoType = gameBoard[row][col];

                    return Pixel(
                      color: tetrominoColors[tetrominoType],

                    );
                  }

                  else{
                    return Pixel(
                      color: Colors.grey[900],
                      
                    );
                  }

                  }
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white
              ),
              child: Center(child: Text(currentScore.toString(), style: TextStyle(color: Colors.black, fontSize: 30),)),
            ),
          ),
          /// Game controls



          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            ///Left
                IconButton(onPressed: moveLeft, icon: Icon(Icons.arrow_back),color: Colors.white,),
            ///Rotate
                IconButton(onPressed: rotatePiece, icon: Icon(Icons.rotate_left_sharp),color: Colors.white,),

            ///Right
                IconButton(onPressed: moveRight, icon: Icon(Icons.arrow_forward),color: Colors.white,),

        ],
      ),
          ),
  ],
      ),
    );
  }
}
