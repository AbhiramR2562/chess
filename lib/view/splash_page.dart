import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // Loading animation
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(); // Make this rotation loop continously
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: [
            // Text
            Positioned(
              top: 370,
              left: 40,
              child: Text(
                "Chess",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 400,
              right: 30,
              child: Text(
                "Awaits",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),

            // Rotating Loading Icon
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: RotationTransition(
                turns: _rotationController,

                child: Image.asset(
                  'assets/images/chess_loading_image.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),

            SizedBox.expand(
              child: Image.asset('assets/images/chess_splash_image.png'),
            ),
          ],
        ),
      ),
    );
  }
}
