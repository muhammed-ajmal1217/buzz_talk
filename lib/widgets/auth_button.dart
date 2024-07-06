
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({
    super.key,
    required this.screenHeight,
    required this.image,
     this.text,
    required this.onPressed,
    
  });

  final double screenHeight;
  final String image;
  final String? text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: screenHeight * 0.10,
        width: screenHeight*0.10,
        decoration: BoxDecoration(
          color: Color(0xff252159).withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,height: 55,),
            SizedBox(width: 6,),
            Text(
              text??'',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.020,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

