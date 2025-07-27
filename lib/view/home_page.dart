import 'package:chess/view/game_board.dart';
import 'package:chess/view/learn_chess_page.dart';
import 'package:chess/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Fade effect
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Pilsing effect
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Fade effect
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();

    // Scale (pulse) animation
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true); // repeat back and forth

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/chess-home-page.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // Settings button
            Positioned(
              top: 70,
              right: 18,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                ),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFFD1776),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.settings, color: Colors.white),
                ),
              ),
            ),

            // Learn chess text
            Positioned(
              top: 84,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnChessPage()),
                  ),

                  child: Text(
                    "LEARN CHESS",
                    style: GoogleFonts.bangers(
                      fontSize: 40,
                      color: Color(0xFF33B0FA),
                    ),
                  ),
                ),
              ),
            ),

            // 1st Arrow
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Color(0xFF33B0FA),
                size: 80,
              ),
            ),
            // 2nd Arrow
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Color(0xFF33B0FA),
                size: 80,
              ),
            ),

            // Start text button
            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameBoard()),
                  ),
                  child: Text(
                    "START",
                    style: GoogleFonts.bangers(
                      fontSize: 110,
                      color: Color(0xFFFD1776),
                    ),
                  ),
                ),
              ),
            ),

            // Two Plyer mode text
            Positioned(
              bottom: 63,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "TWO PLAYER MODE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bangers(
                    fontSize: 75,
                    color: Color(0xFF33B0FA),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
