import 'package:flutter/material.dart';

class PawnPage extends StatelessWidget {
  const PawnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♟ Pawn Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("🔹 Starting Position"),
              sectionText(
                "• White pawns start on rank 2 (row 2).\n• Black pawns start on rank 7 (row 7).",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• Pawns move forward by 1 square.\n• On their first move, pawns can move 2 squares forward.\n• Pawns **cannot** move backward.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Capture"),
              sectionText(
                "• Pawns capture **diagonally** (one square forward-left or forward-right).\n• They **cannot** capture directly in front.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⭐ Special Moves"),

              sectionSubTitle("1. Pawn Promotion"),
              sectionText(
                "• When a pawn reaches the last rank (8 for white, 1 for black), it can promote to a Queen, Rook, Bishop, or Knight.\n• Most players choose a Queen.",
              ),

              const SizedBox(height: 12),
              sectionSubTitle("2. En Passant"),
              sectionText(
                "• If a pawn moves 2 squares forward from its starting position and lands next to an opponent's pawn, the opponent can capture it **as if it moved only 1 square**.\n• This must be done **immediately** on the next turn or the right is lost.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Pawns are powerful when used together.\n• Try to control the center and look for promotion opportunities.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_pawn.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Pawn - The Soul of Chess",
                  style: TextStyle(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) => Text(
    text,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  Widget sectionSubTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );

  Widget sectionText(String text) => Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white70),
    ),
  );
}
