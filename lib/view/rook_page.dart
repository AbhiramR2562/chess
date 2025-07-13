import 'package:flutter/material.dart';

class RookPage extends StatelessWidget {
  const RookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♜ Rook Details',
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
                "• Each player starts with 2 rooks.\n• White rooks: a1 and h1.\n• Black rooks: a8 and h8.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• Rooks move in **straight lines**: horizontally and vertically.\n• They can move any number of squares but cannot jump over other pieces.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Capture"),
              sectionText(
                "• Rooks capture by moving to the square occupied by an enemy piece in a straight line.\n• They follow the same path as their movement rules.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⭐ Special Move"),

              sectionSubTitle("1. Castling"),
              sectionText(
                "• The rook can participate in a special move with the king called **castling**.\n• It’s the only time a rook and king move in the same turn.\n\nCastling Conditions:\n• Neither the king nor the rook involved has moved.\n• No pieces between them.\n• King is not in check and doesn’t pass through or land in check.\n\nThere are two types:\n• Kingside (short): Rook moves from h1/h8 to f1/f8\n• Queenside (long): Rook moves from a1/a8 to d1/d8",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Rooks are strongest on open files.\n• Try to connect your rooks and place them on the 7th rank or open lines.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_rook.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Rook – Power through the lines",
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
