import 'package:chess/data/chess_piece_list.dart';
import 'package:flutter/material.dart';

class LearnChessPage extends StatelessWidget {
  const LearnChessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          'Learn Chess',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '“Understanding each piece is the first step to mastering the game.”',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: chessPieces.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final piece = chessPieces[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => piece.detailPage),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            piece.imageUrl,
                            height: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            piece.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
