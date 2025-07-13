import 'package:flutter/material.dart';

class QueenPage extends StatelessWidget {
  const QueenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♛ Queen Details',
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
                "• Each player has 1 queen.\n• White queen: d1 (starts on a light square).\n• Black queen: d8 (starts on a dark square).",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• The queen combines the power of a **rook and a bishop**.\n• She can move any number of squares:\n   → Horizontally\n   → Vertically\n   → Diagonally\n• But she **cannot jump** over other pieces.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Capture"),
              sectionText(
                "• The queen captures by landing on the square of an enemy piece following her movement rules.\n• She’s a powerful attacker and defender.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⭐ Special Notes"),
              sectionText(
                "• A pawn that promotes usually becomes a **queen**.\n• It’s possible to have **more than one queen** on the board through promotion.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Use the queen to control open files and diagonals.\n• Don't bring the queen out too early – it can become a target.\n• Combine the queen with other pieces (like a bishop or knight) for deadly attacks.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_queen.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Queen – The Powerhouse of the Board",
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
