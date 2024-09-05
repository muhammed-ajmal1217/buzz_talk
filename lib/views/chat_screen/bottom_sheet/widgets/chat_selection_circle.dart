import 'package:flutter/material.dart';

class ChatSelectionCircle extends StatelessWidget {
  const ChatSelectionCircle({
    super.key,
    required this.size,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Size size;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: size.height * 0.03,
            backgroundColor: Color.fromARGB(255, 41, 114, 133).withOpacity(0.4),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Color.fromARGB(255, 91, 136, 142)),
        ),
      ],
    );
  }
}