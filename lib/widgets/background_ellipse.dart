import 'package:flutter/material.dart';

class Ellipses extends StatelessWidget {
  const Ellipses({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return  Stack(
        children: [
          Positioned(
              left: screenWidth *
                  0.04, 
              bottom: screenHeight *
                  0.40, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.95, 
              ),
            ),
            Positioned(
              right: screenWidth *
                  0.28, 
              top: screenHeight *
                  0.10, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.75, 
              ),
            ),
            Positioned(
              left: screenWidth *
                  0.12, 
              top: screenHeight *
                  0.24, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.85, 
              ),
            ),
            Positioned(
              right: screenWidth *
                  0.12, 
              top: screenHeight *
                  0.54, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.85, 
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
              right: screenWidth *
                  0.28, 
              top: screenHeight *
                  0.15, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.75, 
              ),
            ),
            Positioned(
              left: screenWidth *
                  0.12, 
              top: screenHeight *
                  0.20, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.85, 
              ),
            ),
            Positioned(
              right: screenWidth *
                  0.01, 
              top: screenHeight *
                  0.30, 
              child: Image.asset(
                'assets/Ellipse 1.png',
                height:
                    screenHeight * 0.85, 
              ),
            ),
        ],
      );
  }
}