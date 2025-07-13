import 'package:chess/models/chess_piece_info.dart';
import 'package:chess/view/bishop_page.dart';
import 'package:chess/view/king_page.dart';
import 'package:chess/view/knight_page.dart';
import 'package:chess/view/pawn_page.dart';
import 'package:chess/view/queen_page.dart';
import 'package:chess/view/rook_page.dart';

final List<ChessPieceInfo> chessPieces = [
  ChessPieceInfo(
    name: 'Pawn',
    imageUrl: 'assets/images/white_pawn.png',
    detailPage: const PawnPage(),
  ),
  ChessPieceInfo(
    name: 'Rook',
    imageUrl: 'assets/images/white_rook.png',
    detailPage: const RookPage(),
  ),
  ChessPieceInfo(
    name: 'Knight',
    imageUrl: 'assets/images/white_knight.png',
    detailPage: const KnightPage(),
  ),
  ChessPieceInfo(
    name: 'Bishop',
    imageUrl: 'assets/images/white_bishop.png',
    detailPage: const BishopPage(),
  ),
  ChessPieceInfo(
    name: 'Queen',
    imageUrl: 'assets/images/white_queen.png',
    detailPage: const QueenPage(),
  ),
  ChessPieceInfo(
    name: 'King',
    imageUrl: 'assets/images/white_king.png',
    detailPage: const KingPage(),
  ),
];
