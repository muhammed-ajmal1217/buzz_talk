import 'package:flutter/material.dart';

class Ellipses extends StatelessWidget {
  const Ellipses({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          right: screenWidth * -0.96,
          top: screenHeight * 0.44,
          child: Image.asset(
            'assets/Ellipse 5.png',
            height: screenHeight * 0.95,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: screenHeight * 0.48,
          child: Image.asset(
            'assets/chat_icon_backround.png',
            height: screenHeight * 0.75,
          ),
        ),
        Positioned(
          right: screenWidth * -0.3,
          bottom: screenHeight * 0.40,
          child: Image.asset(
            'assets/Ellipse 4.png',
            height: screenHeight * 0.95,
          ),
        ),
      ],
    );
  }
}
class Ellipses1 extends StatelessWidget {
  const Ellipses1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return  Stack(
        children: [
            Positioned(
          left: screenWidth * -0.96,
          bottom: screenWidth*0.3,
          child: Image.asset(
            'assets/Ellipse 15.png',
            height: screenHeight * 0.95,
          ),
        ),
            Positioned(
              left: screenWidth *
                  0.12,
              bottom: screenHeight *
                  0.5,
              child: Image.asset(
                'assets/Ellipse 15.png',
                height:
                    screenHeight * 0.85,
              ),
            ),
            Positioned(
              left: screenWidth *
                  0.01,
              top: screenHeight *
                  0.30,
              child: Image.asset(
                'assets/Ellipse 15.png',
                height:
                    screenHeight * 0.85,
              ),
            ),
        ],
      );
  }
}
