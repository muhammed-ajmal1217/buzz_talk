import 'package:flutter/material.dart';
class AddStoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoryButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
