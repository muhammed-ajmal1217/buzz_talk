import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryPickButton extends StatelessWidget {
  VoidCallback onTap;
  IconData icon;
  String text;
  StoryPickButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            )),
        Text(
          text,
          style: GoogleFonts.montserrat(color: Colors.white),
        )
      ],
    );
  }
}