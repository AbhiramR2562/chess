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
        height: 52,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SvgPicture.asset(imagePath),
              SizedBox(width: 45),
              Text(
                text,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
