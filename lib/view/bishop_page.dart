import 'package:flutter/material.dart';

class BishopPage extends StatelessWidget {
  const BishopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♝ Bishop Details',
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
                "• Each player has 2 bishops.\n• White bishops: c1 (light square) and f1 (dark square).\n• Black bishops: c8 and f8.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• Bishops move diagonally.\n• They can move any number of squares diagonally, but **cannot jump** over other pieces.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Capture"),
              sectionText(
                "• Bishops capture enemy pieces by moving diagonally to their square, following the same movement rules.",
              ),

              const SizedBox(height: 20),
              sectionTitle("⚠️ Limitation"),
              sectionText(
                "• Each bishop can only move on **one color** of square (light or dark).\n• That means a bishop is limited to controlling **half the board**.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Use both bishops together to control large areas (called the **bishop pair**).\n• Bishops are more effective in **open positions** where long diagonals are clear.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_bishop.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Bishop – The Diagonal Master",
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
