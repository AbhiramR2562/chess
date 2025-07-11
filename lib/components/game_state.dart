import 'package:chess/components/piece.dart';

class GameState {
  final List<List<ChessPiece?>> board;
  final List<ChessPiece> whitePiecesTaken;
  final List<ChessPiece> blackPiecesTaken;
  final List<int> whiteKingPosition;
  final List<int> blackKingPosition;
  final bool isWhiteTurn;

  // Castling movement flags
  final bool whiteKingMoved;
  final bool blackKingMoved;
  final bool whiteLeftRookMoved;
  final bool whiteRightRookMoved;
  final bool blackLeftRookMoved;
  final bool blackRightRookMoved;

  GameState({
    required this.board,
    required this.whitePiecesTaken,
    required this.blackPiecesTaken,
    required this.whiteKingPosition,
    required this.blackKingPosition,
    required this.isWhiteTurn,
    required this.whiteKingMoved,
    required this.blackKingMoved,
    required this.whiteLeftRookMoved,
    required this.whiteRightRookMoved,
    required this.blackLeftRookMoved,
    required this.blackRightRookMoved,
  });
}
