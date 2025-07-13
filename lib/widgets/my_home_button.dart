import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomeButton extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final String text;
  const MyHomeButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // Glassmorphic effect
          // Opacity value (0-255),
          color: Color.fromARGB(120, 0, 0, 0), // Adjust transparency
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(125, 255, 255, 255), // 125 = ~50% opacity
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            Container(width: MediaQuery.of(context).size.width * 0.1),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
