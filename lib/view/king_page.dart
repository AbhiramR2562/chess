import 'package:flutter/material.dart';

class KingPage extends StatelessWidget {
  const KingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♚ King Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                "• Each player has 1 king.\n• White king: e1\n• Black king: e8",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• The king moves exactly **one square** in any direction:\n   → Up, down, left, right, and diagonally.\n• The king **cannot move into check** (a square under attack).",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Capture"),
              sectionText(
                "• The king captures by moving one square in any direction to a square occupied by an opponent’s piece, provided it’s not protected.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⭐ Special Move: Castling"),
              sectionText(
                "• Castling is a special king move involving the rook.\n• The king moves two squares toward a rook, and the rook jumps over the king.\n\nConditions:\n• Neither piece has moved before.\n• No pieces between them.\n• The king is not in check, doesn't pass through check, or land in check.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⚠️ Check & Checkmate"),
              sectionText(
                "• Check: The king is under attack.\n• You must remove the threat immediately.\n• Checkmate: The king is in check and **cannot escape** — the game is over.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Keep your king **safe during the opening and middlegame**.\n• **Castle early** to protect your king.\n• In the **endgame**, activate your king — it becomes a strong fighter.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_king.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "King – Protect at All Costs",
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

  Widget sectionText(String text) => Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white70),
    ),
  );
}
