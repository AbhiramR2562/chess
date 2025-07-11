import 'package:chess/components/dead_piece.dart';
import 'package:chess/components/game_state.dart';
import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/helper/helper_methods.dart';
import 'package:chess/values/colors.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // A 2-Dimensional list representing the chessboard,
  // with each position possibly containing a chess piece
  late List<List<ChessPiece?>> board;

  // The currently selected piece on the chess board,
  // if no piece is selected, this is null.
  ChessPiece? selectedPiece;

  // The row index of the selected piece
  // Default value -1 indicate no piece is currently selected.
  int selectedRow = -1;

  // The col index of the selected piece
  // Default value -1 indicate no piece is currently selected.
  int selectedCol = -1;

  //A List of valid moves for the currently selected piece
  // each moves is represented as a list with 2 elements: row, col.
  List<List<int>> validMoves = [];

  // A list of white piece that have been taken by the black player
  List<ChessPiece> whitePiecesTaken = [];

  // A list of black piece that have been taken by the white player
  List<ChessPiece> blackPiecesTaken = [];

  // A booleon to indicate whose turn it is
  bool isWhiteTurn = true;

  // Initial position of kings (keep track of the piece to make it easier later to see if king is in Chekmate)
  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
  bool checkeStatus = false;

  // To track KING CASTLING
  bool whiteKingMoved = false;
  bool blackKingMoved = false;
  bool whiteLeftRookMoved = false;
  bool whiteRightRookMoved = false;
  bool blackLeftRookMoved = false;
  bool blackRightRookMoved = false;

  // UNDO STATE
  List<GameState> previousStates = [];

  // REDO
  List<GameState> redoState = [];

  @override
  void initState() {
    super.initState();

    _initializeBoard();
  }

  // INITIALIZE BOARD
  void _initializeBoard() {
    // Initialize the board with null, meaning no pieces in those position
    List<List<ChessPiece?>> newBoard = List.generate(
      8,
      (index) => List.generate(8, (index) => null),
    );

    // Place Pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'assets/images/white_pawn.png',
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'assets/images/white_pawn.png',
      );
    }

    // Place Rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/images/white_rook.png',
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/images/white_rook.png',
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/images/white_rook.png',
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/images/white_rook.png',
    );

    // Place Knights
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/images/white_knight.png',
    );

    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/images/white_knight.png',
    );

    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/images/white_knight.png',
    );

    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/images/white_knight.png',
    );

    // Place Bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/images/white_bishop.png',
    );

    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/images/white_bishop.png',
    );

    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/images/white_bishop.png',
    );

    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/images/white_bishop.png',
    );

    // Place Queens
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: 'assets/images/white_queen.png',
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: 'assets/images/white_queen.png',
    );

    // Place Kings
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: 'assets/images/white_king.png',
    );

    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: 'assets/images/white_king.png',
    );

    board = newBoard;
  }

  // USER SELECTED A PIECE
  void pieceSelected(int row, int col) {
    setState(() {
      // No piece has been selected yet, this is the first selection
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.isWhite == isWhiteTurn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      }
      // There is a piece already selected, but user can select another one of their piece
      else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      // If there is a piece selected and user taps on a square that is a valid move, move there
      else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }

      // If a piece is selected , calculate it's valid moves
      validMoves = calculateRealValidMoves(
        selectedRow,
        selectedCol,
        selectedPiece,
        true,
      );
    });
  }

  // CALCULATE RAW VALID MOVES
  List<List<int>> calculateRawValidMoves(
    int row,
    int col,
    ChessPiece? piece,
    bool checkSimulation,
  ) {
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    // different directions based on their color
    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        // Pawns can move forward if the square is not occupied
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // Pawns can move 2 square forward if they are at their initial position
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // Pawns can kill diagonally
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
        break;
      case ChessPieceType.rook:
        // Horizontal and vertical
        var directions = [
          [-1, 0], // Up
          [1, 0], // Down
          [0, -1], // Left
          [0, 1], // Right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];

            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // can Kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        // all eight possible L shapes theknight can move
        var knightMoves = [
          [-2, -1], // Up 2 Left 1
          [-2, 1], // Up 2 Right 1
          [-1, -2], // Up 1 Left 2
          [-1, 2], // Up 1 Right 2
          [1, -2], // Down 1 Left 2
          [1, 2], // Down 1 Right 2
          [2, -1], // Down 2 Left 1
          [2, 1], // Down 2 Right 1
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];

          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // Kill
            }
            continue; // blocked
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;
      case ChessPieceType.bishop:
        var directions = [
          [-1, -1], // Up Left
          [-1, 1], // Up right
          [1, -1], // down Left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // Kill
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        // All eight directions: Up, down, left, and 4 diagonals
        var directions = [
          [-1, 0], // Up
          [1, 0], // Down
          [0, -1], // Left
          [0, 1], // Right
          [-1, -1], // Up Left
          [-1, 1], // Up right
          [1, -1], // down Left
          [1, 1], // down right
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // Kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        // All eight directions
        var directions = [
          [-1, 0], // Up
          [1, 0], // Down
          [0, -1], // Left
          [0, 1], // Right
          [-1, -1], // Up Left
          [-1, 1], // Up right
          [1, -1], // Down Left
          [1, 1], // Down right
        ];

        for (var direction in directions) {
          int newRow = row + direction[0];
          int newCol = col + direction[1];

          if (!isInBoard(newRow, newCol)) continue;

          // Add if empty or enemy piece
          if (board[newRow][newCol] == null ||
              board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]);
          }
        }

        // CASTLING LOGIC AFTER NORMAL KING MOVES

        if (piece.isWhite &&
            !whiteKingMoved &&
            row == 7 &&
            col == 4 &&
            checkSimulation) {
          // King-side castling

          if (!whiteRightRookMoved &&
              board[7][5] == null &&
              board[7][6] == null &&
              !isKingInCheck(true) &&
              simulatedMovesIsSafe(piece, row, col, 7, 5) &&
              simulatedMovesIsSafe(piece, row, col, 7, 6)) {
            candidateMoves.add([7, 6]);
          }

          // Queen-side castling
          if (!whiteLeftRookMoved &&
              board[7][2] == null &&
              board[7][3] == null &&
              !isKingInCheck(true) &&
              simulatedMovesIsSafe(piece, row, col, 7, 3) &&
              simulatedMovesIsSafe(piece, row, col, 7, 2)) {
            candidateMoves.add([7, 2]);
          }
        }
        // Black king castling
        else if (!blackKingMoved && row == 0 && col == 4 && checkSimulation) {
          // King-side castling
          if (!blackRightRookMoved &&
              board[0][5] == null &&
              board[0][6] == null &&
              !isKingInCheck(false) &&
              simulatedMovesIsSafe(piece, row, col, 0, 5) &&
              simulatedMovesIsSafe(piece, row, col, 0, 6)) {
            candidateMoves.add([0, 6]);
          }

          // Queen-side castling
          if (!blackLeftRookMoved &&
              board[0][2] == null &&
              board[0][3] == null &&
              !isKingInCheck(false) &&
              simulatedMovesIsSafe(piece, row, col, 0, 3) &&
              simulatedMovesIsSafe(piece, row, col, 0, 2)) {
            candidateMoves.add([0, 2]);
          }
        }

        break;
      default:
    }

    return candidateMoves;
  }

  // CALCULATE REAL VALID MOVES
  List<List<int>> calculateRealValidMoves(
    int row,
    int col,
    ChessPiece? piece,
    bool checkSimulation,
  ) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = calculateRawValidMoves(
      row,
      col,
      piece,
      checkSimulation,
    );

    // After generating all candidate moves, filter out any that would result in a check
    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];

        // this will simulate the future move to see if it's safe
        if (simulatedMovesIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

  // MOVE PIECE
  void movePiece(int newRow, int newCol) async {
    redoState.clear();

    // Save current state for undo
    previousStates.add(
      GameState(
        board: board
            .map(
              (row) => row
                  .map(
                    (piece) => piece == null
                        ? null
                        : ChessPiece(
                            type: piece.type,
                            isWhite: piece.isWhite,
                            imagePath: piece.imagePath,
                          ),
                  )
                  .toList(),
            )
            .toList(),
        whitePiecesTaken: List.from(whitePiecesTaken),
        blackPiecesTaken: List.from(blackPiecesTaken),
        whiteKingPosition: List.from(whiteKingPosition),
        blackKingPosition: List.from(blackKingPosition),
        isWhiteTurn: isWhiteTurn,

        // Add castling flags here:
        whiteKingMoved: whiteKingMoved,
        blackKingMoved: blackKingMoved,
        whiteLeftRookMoved: whiteLeftRookMoved,
        whiteRightRookMoved: whiteRightRookMoved,
        blackLeftRookMoved: blackLeftRookMoved,
        blackRightRookMoved: blackRightRookMoved,
      ),
    );

    // check if the piece king moved is a king and attempting to castle
    bool isCastlingMove = false;
    if (selectedPiece!.type == ChessPieceType.king) {
      // White King castling
      if (selectedPiece!.isWhite && selectedRow == 7 && selectedCol == 4) {
        if (newRow == 7 && newCol == 6) {
          // white king-side castling
          board[7][5] = board[7][7];
          board[7][7] = null;
          isCastlingMove = true;
          whiteRightRookMoved = true;
        } else if (newRow == 7 && newCol == 2) {
          // white queen - side castling
          board[7][3] = board[7][0];
          board[7][0] = null;
          isCastlingMove = true;
          whiteLeftRookMoved = true;
        }
        whiteKingMoved = true;
      }

      // Black king castling
      if (!selectedPiece!.isWhite && selectedRow == 0 && selectedCol == 4) {
        if (newRow == 0 && newCol == 6) {
          // Black king - side castling
          board[0][5] = board[0][7];
          board[0][7] = null;
          isCastlingMove = true;
          blackRightRookMoved = true;
        } else if (newRow == 0 && newCol == 2) {
          // Black queen - side castling
          board[0][3] = board[0][0];
          board[0][0] = null;
          isCastlingMove = true;
          blackLeftRookMoved = true;
        }
        blackKingMoved = true;
      }
    }

    // If the new spot has an enemy piece
    if (board[newRow][newCol] != null) {
      // add the capture piece to the appropriate list
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }
    }

    // move the piece and clear the old post
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // Update king's position
    if (selectedPiece!.type == ChessPieceType.king) {
      if (selectedPiece!.isWhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    // Update rook move flags if a rook is moved (to display future castling)
    if (selectedPiece!.type == ChessPieceType.rook) {
      if (selectedPiece!.isWhite) {
        if (selectedRow == 7 && selectedCol == 0) whiteLeftRookMoved = true;
        if (selectedRow == 7 && selectedCol == 7) whiteRightRookMoved = true;
      } else {
        if (selectedRow == 0 && selectedCol == 0) blackLeftRookMoved = true;
        if (selectedRow == 0 && selectedCol == 7) blackRightRookMoved = true;
      }
    }

    // Pawn promotion
    // Check if the piece is a pawn and reched promotion row
    bool isPromotion =
        selectedPiece!.type == ChessPieceType.pawn &&
        (newRow == 0 || newRow == 7);

    // If Promotion, show dialog before clearing selectedPiece
    if (isPromotion) {
      selectedRow = newRow;
      selectedCol = newCol;
      await _showPromotionDialog();
    }

    // See if any kings are under attack
    if (isKingInCheck(!isWhiteTurn)) {
      checkeStatus = true;
    } else {
      checkeStatus = false;
    }

    // Clear the selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

    // Check if it's check mate
    if (isCheckMate(!isWhiteTurn)) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("CHECK MATE!"),
          actions: [
            // Buttons
            TextButton(onPressed: resetGame, child: const Text("Play Again")),
          ],
        ),
      );
    }

    // Check if it's draw
    if (isDraw(!isWhiteTurn)) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("DRAW!"),
          content: Text("It's a stalemate."),
          actions: [
            TextButton(onPressed: resetGame, child: Text("Restart Game")),
          ],
        ),
      );
    }

    // Change turns
    isWhiteTurn = !isWhiteTurn;
  }

  // IS KING IN CHECK
  bool isKingInCheck(bool isWhiteKIng) {
    // get the position of the king
    List<int> kingPosition = isWhiteKIng
        ? whiteKingPosition
        : blackKingPosition;

    // Check any enemy piece can attack the king
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // Skip empty square and pieces of the same color as the king
        if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKIng) {
          continue;
        }
        List<List<int>> pieceValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          false,
        );

        // check if the king's position is in theis piece's valid moves
        if (pieceValidMoves.any(
          (move) => move[0] == kingPosition[0] && move[1] == kingPosition[1],
        )) {
          return true;
        }
      }
    }
    return false;
  }

  // SIMULATE A FUTURE MOVE TO SEE IF IT'S SAFE (DOESN'T PUT YOUR OWN KING UNDER ATTACK!)
  bool simulatedMovesIsSafe(
    ChessPiece piece,
    int startRow,
    int startCol,
    int endRow,
    int endCol,
  ) {
    // Save the current board state
    ChessPiece? originalDestinationPiece = board[endRow][endCol];

    // If the piece is the king, save it's current position and update to the new one
    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition = piece.isWhite
          ? whiteKingPosition
          : blackKingPosition;

      // Update the king position
      if (piece.isWhite) {
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }

    // Simulate the move
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    // Check if our king is under attack
    bool kingInCheck = isKingInCheck(piece.isWhite);

    // Rstore board to orginal state
    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    // If the piece was king, restore it orginal position
    if (piece.type == ChessPieceType.king) {
      if (piece.isWhite) {
        whiteKingPosition = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }

    // If the king is in check = true, means it's not a safe move. safe move = false.
    return !kingInCheck;
  }

  // IS IT CHECK MATE
  bool isCheckMate(bool isWhiteKing) {
    // if the king is not in check, then it is not checkmate
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }

    // if there is at least one legal move for any of the player's pieces, then it's not checkmate
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // Skip empty square and piece of the other color
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
          continue;
        }
        List<List<int>> pieceValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          true,
        );

        // If this piece has any valid moves , then it's not Chekmate
        if (pieceValidMoves.isNotEmpty) {
          return false;
        }
      }
    }

    // if none of the above conditions are met, then there are no legal moves left to make
    // It's CHECK MATE!
    return true;
  }

  // RESET TEH GAME
  void resetGame() {
    Navigator.pop(context);

    _initializeBoard();

    checkeStatus = false;
    isWhiteTurn = true;

    whitePiecesTaken.clear();
    blackPiecesTaken.clear();

    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];

    // Reset caslitng flags
    whiteKingMoved = false;
    blackKingMoved = false;
    whiteLeftRookMoved = false;
    whiteRightRookMoved = false;
    blackLeftRookMoved = false;
    blackRightRookMoved = false;

    // Reset undo/redo history
    previousStates.clear();
    redoState.clear();

    setState(() {});
  }

  // PAWN prmotion Dialog box
  Future<void> _showPromotionDialog() async {
    List<ChessPieceType> promotionOptions = [
      ChessPieceType.queen,
      ChessPieceType.bishop,
      ChessPieceType.knight,
      ChessPieceType.rook,
    ];

    ChessPieceType? selectedType = await showDialog<ChessPieceType>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Promote Pawn"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: promotionOptions.map((type) {
            return ListTile(
              leading: Image.asset(
                'assets/images/white_${type.name}.png',
                width: 36,
                height: 36,
                color: selectedPiece!.isWhite ? Colors.white : Colors.black,
              ),
              title: Text(getPieceName(type)),
              onTap: () => Navigator.pop(context, type),
            );
          }).toList(),
        ),
      ),
    );

    if (selectedType != null) {
      setState(() {
        board[selectedRow][selectedCol] = null;
        selectedPiece = ChessPiece(
          type: selectedType,
          isWhite: selectedPiece!.isWhite,
          imagePath: 'assets/images/white_${selectedType.name}.png',
        );
        board[selectedRow][selectedCol] = selectedPiece;
      });
    }
  }

  // RESTART
  void restartGame() {
    _initializeBoard();
    checkeStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    isWhiteTurn = true;
    selectedPiece = null;
    selectedRow = -1;
    selectedCol = -1;
    validMoves = [];

    // Reset castling flags
    whiteKingMoved = false;
    blackKingMoved = false;
    whiteLeftRookMoved = false;
    whiteRightRookMoved = false;
    blackLeftRookMoved = false;
    blackRightRookMoved = false;

    setState(() {});
  }

  // UNDO
  void undoMove() {
    if (previousStates.isNotEmpty) {
      final lastState = previousStates.removeLast();

      // Save current state to redo stack before undoing
      redoState.add(
        GameState(
          board: board
              .map(
                (row) => row
                    .map(
                      (piece) => piece == null
                          ? null
                          : ChessPiece(
                              type: piece.type,
                              isWhite: piece.isWhite,
                              imagePath: piece.imagePath,
                            ),
                    )
                    .toList(),
              )
              .toList(),
          whitePiecesTaken: List.from(whitePiecesTaken),
          blackPiecesTaken: List.from(blackPiecesTaken),
          whiteKingPosition: List.from(whiteKingPosition),
          blackKingPosition: List.from(blackKingPosition),
          isWhiteTurn: isWhiteTurn,
          whiteKingMoved: whiteKingMoved,
          blackKingMoved: blackKingMoved,
          whiteLeftRookMoved: whiteLeftRookMoved,
          whiteRightRookMoved: whiteRightRookMoved,
          blackLeftRookMoved: blackLeftRookMoved,
          blackRightRookMoved: blackRightRookMoved,
        ),
      );

      setState(() {
        board = lastState.board
            .map(
              (row) => row
                  .map(
                    (piece) => piece == null
                        ? null
                        : ChessPiece(
                            type: piece.type,
                            isWhite: piece.isWhite,
                            imagePath: piece.imagePath,
                          ),
                  )
                  .toList(),
            )
            .toList();

        whitePiecesTaken = lastState.whitePiecesTaken
            .map(
              (piece) => ChessPiece(
                type: piece.type,
                isWhite: piece.isWhite,
                imagePath: piece.imagePath,
              ),
            )
            .toList();

        blackPiecesTaken = lastState.blackPiecesTaken
            .map(
              (piece) => ChessPiece(
                type: piece.type,
                isWhite: piece.isWhite,
                imagePath: piece.imagePath,
              ),
            )
            .toList();

        whiteKingPosition = List.from(lastState.whiteKingPosition);
        blackKingPosition = List.from(lastState.blackKingPosition);
        isWhiteTurn = lastState.isWhiteTurn;

        // Restore castling flags
        whiteKingMoved = lastState.whiteKingMoved;
        blackKingMoved = lastState.blackKingMoved;
        whiteLeftRookMoved = lastState.whiteLeftRookMoved;
        whiteRightRookMoved = lastState.whiteRightRookMoved;
        blackLeftRookMoved = lastState.blackLeftRookMoved;
        blackRightRookMoved = lastState.blackRightRookMoved;

        selectedPiece = null;
        selectedRow = -1;
        selectedCol = -1;
        validMoves = [];

        checkeStatus = isKingInCheck(!isWhiteTurn);
      });
    }
  }

  // REDO MOVE
  void redoMove() {
    if (redoState.isNotEmpty) {
      GameState nextState = redoState.removeLast();

      // Save current state to undo stack before redoing
      previousStates.add(
        GameState(
          board: board
              .map(
                (row) => row
                    .map(
                      (piece) => piece == null
                          ? null
                          : ChessPiece(
                              type: piece.type,
                              isWhite: piece.isWhite,
                              imagePath: piece.imagePath,
                            ),
                    )
                    .toList(),
              )
              .toList(),
          whitePiecesTaken: List.from(whitePiecesTaken),
          blackPiecesTaken: List.from(blackPiecesTaken),
          whiteKingPosition: List.from(whiteKingPosition),
          blackKingPosition: List.from(blackKingPosition),
          isWhiteTurn: isWhiteTurn,
          whiteKingMoved: whiteKingMoved,
          blackKingMoved: blackKingMoved,
          whiteLeftRookMoved: whiteLeftRookMoved,
          whiteRightRookMoved: whiteRightRookMoved,
          blackLeftRookMoved: blackLeftRookMoved,
          blackRightRookMoved: blackRightRookMoved,
        ),
      );

      setState(() {
        board = nextState.board;
        whitePiecesTaken = nextState.whitePiecesTaken;
        blackPiecesTaken = nextState.blackPiecesTaken;
        whiteKingPosition = nextState.whiteKingPosition;
        blackKingPosition = nextState.blackKingPosition;
        isWhiteTurn = nextState.isWhiteTurn;

        // Restore castling rights
        whiteKingMoved = nextState.whiteKingMoved;
        blackKingMoved = nextState.blackKingMoved;
        whiteLeftRookMoved = nextState.whiteLeftRookMoved;
        whiteRightRookMoved = nextState.whiteRightRookMoved;
        blackLeftRookMoved = nextState.blackLeftRookMoved;
        blackRightRookMoved = nextState.blackRightRookMoved;

        selectedPiece = null;
        selectedRow = -1;
        selectedCol = -1;
        validMoves = [];
        checkeStatus = isKingInCheck(!isWhiteTurn);
      });
    }
  }

  // Check the Game is DRAW
  bool isDraw(bool isWhitePlayer) {
    // if the king is in check, it's not a draw
    if (isKingInCheck(isWhitePlayer)) return false;

    // Check if any piece has valid moves
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        final piece = board[i][j];
        if (piece != null && piece.isWhite == isWhitePlayer) {
          final moves = calculateRealValidMoves(i, j, piece, true);
          if (moves.isNotEmpty) return false;
        }
      }
    }

    return true; // No valid moves and not in check -> DRAW
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 54, 60, 85),
        appBar: AppBar(
          actions: [
            // Undo
            IconButton(
              onPressed: undoMove,
              icon: Icon(Icons.undo, color: Colors.black),
            ),
            // Reso
            IconButton(
              onPressed: redoMove,
              icon: Icon(Icons.redo, color: Colors.black),
            ),
            // Restart
            IconButton(
              onPressed: restartGame,
              icon: Icon(Icons.restart_alt, color: Colors.black),
            ),
          ],
        ),
        body: Column(
          children: [
            // WHITE PIECES TAKEN
            Expanded(
              child: GridView.builder(
                itemCount: whitePiecesTaken.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => DeadPiece(
                  imagePath: whitePiecesTaken[index].imagePath,
                  isWhite: true,
                ),
              ),
            ),

            // Game Status
            Text(
              checkeStatus ? "CHECK" : "",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // CHESS BOARD
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 8 * 8,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) {
                  // get the row and col position of this square
                  int row = index ~/ 8;
                  int col = index % 8;

                  // Check if the current square selected or not
                  bool isSelected = selectedRow == row && selectedCol == col;

                  // Check if this square is a valid move
                  bool isValidMove = false;
                  for (var position in validMoves) {
                    // compare the row and col
                    if (position[0] == row && position[1] == col) {
                      isValidMove = true;
                    }
                  }

                  return Square(
                    isWhite: isWhite(index),
                    piece: board[row][col],
                    isSelected: isSelected,
                    isValidMove: isValidMove,
                    onTap: () => pieceSelected(row, col),
                  );
                },
              ),
            ),

            // BLACK PIECES TAKEN
            Expanded(
              child: GridView.builder(
                itemCount: blackPiecesTaken.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => DeadPiece(
                  imagePath: blackPiecesTaken[index].imagePath,
                  isWhite: false,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
