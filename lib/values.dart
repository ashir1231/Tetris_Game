
//Grid dimensions
import 'dart:ui';

int rowLength = 10;
int colLength = 15;
enum Direction{
  left,
  right,
  down,
}

enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors ={
  Tetromino.L: Color(0xffffa500),
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color(0xffffff00),
  Tetromino.S: Color(0xff008000),
  Tetromino.Z: Color(0xffff0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};