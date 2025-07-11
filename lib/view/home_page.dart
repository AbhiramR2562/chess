import 'package:chess/view/game_board.dart';
import 'package:chess/widgets/my_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Image.asset('assets/images/chess_top_image.jpg'),
          ),
          Column(
            children: [
              MyHomeButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameBoard()),
                ),
                imagePath: 'assets/images/2_player_icon.svg',
                text: "2 Player",
              ),
              SizedBox(height: 40),
              MyHomeButton(
                onTap: () {},
                imagePath: 'assets/images/learn_chess_icon.svg',
                text: "Learn Chess",
              ),
              SizedBox(height: 40),
              MyHomeButton(
                onTap: () {},
                imagePath: 'assets/images/settings_icon.svg',
                text: "Settings",
              ),
            ],
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     // heightFactor: 0.7, // Show 70% from top
            //     child: Image.asset(
            //       'assets/images/chess_bottum_image.png',
            //       fit: BoxFit.scaleDown,
            //       height: 200,
            //       width: MediaQuery.of(context).size.width,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
