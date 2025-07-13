import 'package:chess/data/chess_piece_list.dart';
import 'package:chess/view/game_board.dart';
import 'package:chess/view/learn_chess_page.dart';
import 'package:chess/view/settings_page.dart';
import 'package:chess/widgets/my_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  'assets/images/home_page_background_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Head
              Positioned(
                left: 0,
                right: 0,

                top: 60,
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    // Glassmorphic effect
                    // Opacity value (0-255),
                    color: Color.fromARGB(120, 0, 0, 0), // Adjust transparency
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(
                        125,
                        255,
                        255,
                        255,
                      ), // 125 = ~50% opacity
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Power in Every Piece",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          "Control the board, control the game own your space.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.445,
                      child: Image.asset(
                        'assets/images/3D_Fantasy.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        // Glassmorphic effect
                        // Opacity value (0-255),
                        // Opacity value (0-255),
                        color: Color.fromARGB(
                          180,
                          15,
                          15,
                          15,
                        ), // dark translucent
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color.fromARGB(
                            125,
                            255,
                            255,
                            255,
                          ), // 125 = ~50% opacity
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: 37),
                          SvgPicture.asset(
                            'assets/images/2_player_icon.svg',
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Two",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Player Mode",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameBoard(),
                              ),
                            ),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 460,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    MyHomeButton(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LearnChessPage(),
                        ),
                      ),
                      imagePath: 'assets/images/learn_chess_icon.svg',
                      text: "Learn Chess",
                    ),
                    SizedBox(height: 50),
                    MyHomeButton(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      ),
                      imagePath: 'assets/images/settings_icon.svg',
                      text: "Settings",
                    ),
                  ],
                ),
              ),

              // Card Slide
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  Horizontally scrollable ListView
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: chessPieces.length,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          itemBuilder: (context, index) {
                            final piece = chessPieces[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => piece.detailPage,
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(180, 15, 15, 15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      125,
                                      255,
                                      255,
                                      255,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(piece.imageUrl, height: 30),
                                    const SizedBox(height: 4),
                                    Text(
                                      piece.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      //  Arrow icon indicating scroll
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
