

import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece{
  bool positionIsValid(int position){
    int row=(position/rowLength).floor();
    int col= position % rowLength;

    if(row < 0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }else{
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition){
    bool firstColumnOccupied = false;
    bool lastColumnOccupied = false;

    for(int pos in piecePosition){
      if(!positionIsValid(pos)){
        return false;
      }

      int col = pos % rowLength;
      if(col == 0){
        firstColumnOccupied = true;
      }
      if(col == rowLength - 1){
        lastColumnOccupied = true;
      }
    }

    return !(firstColumnOccupied && lastColumnOccupied);
  }
  //Type of tetris piece
  Tetromino type;

  Piece({required this.type});

  //The piece is just a list of integers
  List<int> position = [];

  // color ot tetris piece
  Color get color{
    return tetrominoColors[type] ?? Colors.white;
  }
  //Generate the integers

  void intializePiece(){
    switch (type){
        case Tetromino.L:
        position=[
          -26,
          -16,
          -6,
          -5,
      ];
        break;
      case Tetromino.J:
        position=[
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position=[
          -4,-5,-6,-7,
        ];
        break;
      case Tetromino.O:
        position=[
          -15,-16,-5,-6,
        ];
        break;
      case Tetromino.S:
        position=[
          -15,-14,-6,-5,
        ];
        break;
      case Tetromino.Z:
        position=[
          -17,-16,-6,-5,
        ];
        break;

      case Tetromino.T:
        position=[
          -26,-16,-6,-15,
        ];
        break;
      default:

    }
  }
  //Move piece

void movePiece(Direction direction){
    switch(direction)
    {
      case Direction.down:
        for(int i=0; i<position.length; i++){
          position[i] += rowLength;
        }
        break;

      case Direction.left:
        for(int i=0; i<position.length; i++){
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for(int i=0; i<position.length; i++){
          position[i] += 1;
        }
      default:
    }
}
int rotateState=1;
  void rotatePiece(){
    List<int> newPosition = [];

    switch (type){
      case Tetromino.L:
        switch(rotateState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - -1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }break;
            ///its j
          case Tetromino.J:
            switch(rotateState){
              case 0:
                newPosition=[
                  position[1] - rowLength,
                  position[1],
                  position[1] + rowLength,
                  position[1] - rowLength - 1,
                ];
                if(piecePositionIsValid(newPosition)){
                  position=newPosition;
                  rotateState = (rotateState + 1) %4;
                }
                break;
              case 1:
                newPosition=[
                  position[1] - rowLength - 1,
                  position[1],
                  position[1] - 1,
                  position[1] + 1,
                ];
                if(piecePositionIsValid(newPosition)){
                  position=newPosition;
                  rotateState = (rotateState + 1) %4;
                }
                break;
              case 2:
                newPosition=[
                  position[1] + rowLength,
                  position[1],
                  position[1] - rowLength,
                  position[1] - rowLength + 1,
                ];
                if(piecePositionIsValid(newPosition)){
                  position=newPosition;
                  rotateState = (rotateState + 1) %4;
                }
                break;
              case 3:
                newPosition=[
                  position[1]  + 1,
                  position[1],
                  position[1] - 1,
                  position[1] + rowLength -1,
                ];
                if(piecePositionIsValid(newPosition)){
                  position=newPosition;
                  rotateState = (rotateState + 1) %4;
                }
                break;
            }break;
            ///its I
              case Tetromino.I:
                switch(rotateState) {
                  case 0:
                    newPosition = [
                      position[1] - 1,
                      position[1],
                      position[1] + 1,
                      position[1] + 2,
                    ];
                    if (piecePositionIsValid(newPosition)) {
                      position = newPosition;
                      rotateState = (rotateState + 1) % 4;
                    }
                    break;
                  case 1:
                    newPosition = [
                      position[1] - rowLength,
                      position[1],
                      position[1] + rowLength,
                      position[1] + 2 * rowLength,
                    ];
                    if (piecePositionIsValid(newPosition)) {
                      position = newPosition;
                      rotateState = (rotateState + 1) % 4;
                    }
                    break;
                  case 2:
                    newPosition = [
                      position[1] + 1,
                      position[1],
                      position[1] - 1,
                      position[1] - 2,
                    ];
                    if (piecePositionIsValid(newPosition)) {
                      position = newPosition;
                      rotateState = (rotateState + 1) % 4;
                    }
                    break;
                  case 3:
                    newPosition = [
                      position[1] + rowLength,
                      position[1],
                      position[1] - rowLength,
                      position[1] - 2 * rowLength,
                    ];
                    if (piecePositionIsValid(newPosition)) {
                      position = newPosition;
                      rotateState = (rotateState + 1) % 4;
                    }
                    break;
                }break;

                ///Its O
                  case Tetromino.O:
                    break;

                ///its S
                  case Tetromino.S:
                    switch (rotateState) {
                      case 0:
                        newPosition = [
                          position[1],
                          position[1] + 1,
                          position[1] + rowLength - 1,
                          position[1] + rowLength,
                        ];
                        if (piecePositionIsValid(newPosition)) {
                          position = newPosition;
                          rotateState = (rotateState + 1) % 4;
                        }
                        break;
                      case 1:
                        newPosition = [
                          position[1] - rowLength,
                          position[1],
                          position[1] + 1,
                          position[1] + rowLength + 1,
                        ];
                        if (piecePositionIsValid(newPosition)) {
                          position = newPosition;
                          rotateState = (rotateState + 1) % 4;
                        }
                        break;
                      case 2:
                        newPosition = [
                          position[1],
                          position[1] + 1,
                          position[1] + rowLength - 1,
                          position[1] + rowLength,
                        ];
                        if (piecePositionIsValid(newPosition)) {
                          position = newPosition;
                          rotateState = (rotateState + 1) % 4;
                        }
                        break;
                      case 3:
                        newPosition = [
                          position[1] - rowLength,
                          position[1],
                          position[1] + 1,
                          position[1] + rowLength + 1,
                        ];
                        if (piecePositionIsValid(newPosition)) {
                          position = newPosition;
                          rotateState = (rotateState + 1) % 4;
                        }

                        break;
                    }break;

                    ///its Z
                      case Tetromino.Z:
                        switch (rotateState) {
                          case 0:
                            newPosition = [
                              position[1] + rowLength - 2,
                              position[1],
                              position[1] + rowLength - 1,
                              position[1] + 1,
                            ];
                            if (piecePositionIsValid(newPosition)) {
                              position = newPosition;
                              rotateState = (rotateState + 1) % 4;
                            }
                            break;
                          case 1:
                            newPosition = [
                              position[1] - rowLength - 2,
                              position[1],
                              position[1] - rowLength + 1,
                              position[1] - 1,
                            ];
                            if (piecePositionIsValid(newPosition)) {
                              position = newPosition;
                              rotateState = (rotateState + 1) % 4;
                            }
                            break;
                          case 2:
                            newPosition = [
                              position[1] + rowLength - 2,
                              position[1],
                              position[1] + rowLength - 1,
                              position[1] + 1,
                            ];
                            if (piecePositionIsValid(newPosition)) {
                              position = newPosition;
                              rotateState = (rotateState + 1) % 4;
                            }
                            break;
                          case 3:
                            newPosition = [
                              position[1] - rowLength - 2,
                              position[1],
                              position[1] - rowLength + 1,
                              position[1] - 1,
                            ];
                            if (piecePositionIsValid(newPosition)) {
                              position = newPosition;
                              rotateState = (rotateState + 1) % 4;
                            }
                            break;
                        }break;

                        ///its T
                          case Tetromino.T:
                            switch (rotateState) {
                              case 0:
                                newPosition = [
                                  position[1] - rowLength,
                                  position[1],
                                  position[1] + 1,
                                  position[1] + rowLength,
                                ];
                                if (piecePositionIsValid(newPosition)) {
                                  position = newPosition;
                                  rotateState = (rotateState + 1) % 4;
                                }
                                break;
                              case 1:
                                newPosition = [
                                  position[1] - 1,
                                  position[1],
                                  position[1] + 1,
                                  position[1] + rowLength,
                                ];
                                if (piecePositionIsValid(newPosition)) {
                                  position = newPosition;
                                  rotateState = (rotateState + 1) % 4;
                                }
                                break;
                              case 2:
                                newPosition = [
                                  position[1] - rowLength,
                                  position[1] - 1,
                                  position[1],
                                  position[1] + rowLength,
                                ];
                                if (piecePositionIsValid(newPosition)) {
                                  position = newPosition;
                                  rotateState = (rotateState + 1) % 4;
                                }
                                break;
                              case 3:
                                newPosition = [
                                  position[1] - rowLength,
                                  position[1] - 1,
                                  position[1],
                                  position[1] + 1,
                                ];
                                if (piecePositionIsValid(newPosition)) {
                                  position = newPosition;
                                  rotateState = (rotateState + 1) % 4;
                                }
                                break;
                            }break;
                              default:
                            }
                        }
                    }
