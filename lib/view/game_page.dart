import 'package:chess/components/dead_piece.dart';
import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/helper/helper_methods.dart';
import 'package:chess/values/colors.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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

    // // place random piece in middle to test
    // newBoard[3][3] = ChessPiece(
    //   type: ChessPieceType.king,
    //   isWhite: false,
    //   imagePath: 'assets/images/white_king.png',
    // );

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
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
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
          [1, -1], // down Left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
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
    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);

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
  void movePiece(int newRow, int newCol) {
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

    //    // Check if the piece being moved is a pawn reaching the last row
    // if (selectedPiece!.type == ChessPieceType.pawn && (newRow == 0 || newRow == 7)) {
    //   // Prompt the player to choose a piece to replace the pawn with
    //   // You can implement your own logic here, like showing a dialog or a bottom sheet
    //   // Let's assume you have a method called selectReplacementPiece which handles this
    //   selectReplacementPiece(newRow, newCol);
    //   return; // Exit the movePiece method, the actual replacement will happen after the player selects a piece
    // }

    // Check if the piece being moved in a king
    if (selectedPiece!.type == ChessPieceType.king) {
      // Update the appropriate king position
      if (selectedPiece!.isWhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    // move the piece and clear the old post
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

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
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    isWhiteTurn = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
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
