import 'package:chess/components/piece.dart';

bool isWhite(int index) {
  int x = index ~/ 8; //=> this gives as the integer division ie. Row
  int y = index % 8; //=> this gives as the reminder ie. Column

  // Alternate Colors for each square
  bool isWhite = (x + y) % 2 == 0;

  return isWhite;
}

// Checking the piece in the bord or not
bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}

String getPieceName(ChessPieceType type) {
  switch (type) {
    case ChessPieceType.pawn:
      return 'PAWN';
    case ChessPieceType.rook:
      return 'ROOK';
    case ChessPieceType.knight:
      return 'KNIGHT';
    case ChessPieceType.bishop:
      return 'BISHOP';
    case ChessPieceType.queen:
      return 'QUEEN';
    case ChessPieceType.king:
      return 'KING';
  }
}
