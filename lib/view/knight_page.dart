import 'package:flutter/material.dart';

class KnightPage extends StatelessWidget {
  const KnightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          '♞ Knight Details',
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
                "• Each player has 2 knights.\n• White knights: b1 and g1.\n• Black knights: b8 and g8.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Movement"),
              sectionText(
                "• Knights move in an **L-shape**: 2 squares in one direction and then 1 square perpendicular.\n• Example: 2 up, 1 right OR 2 left, 1 down, etc.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔺 Unique Ability"),
              sectionText(
                "• Knights are the **only piece** that can **jump over other pieces**.\n• They ignore all obstacles in their path when moving.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🔸 Capture"),
              sectionText(
                "• Knights capture by landing on a square occupied by an enemy piece in their L-shaped path.\n• They do **not** capture in a straight line or diagonally.",
              ),

              const SizedBox(height: 20),
              sectionTitle("🎯 Strategy Tip"),
              sectionText(
                "• Knights are strong in **closed positions** where other pieces are blocked.\n• Place knights in the center to control up to 8 squares.\n• A knight on the edge is said to be **'dim' or 'grim'** — it controls fewer squares.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/white_knight.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Knight – The Jumping Warrior",
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
