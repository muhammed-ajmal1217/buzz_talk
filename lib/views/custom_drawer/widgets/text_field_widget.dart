import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreDetailsTextWidgets extends StatelessWidget {
  MoreDetailsTextWidgets({
    super.key,
    required this.auth,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.maxLines,
  });

  final FirebaseAuth auth;
  final TextEditingController controller;
  String hintText;
  TextInputType keyboardType;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: GoogleFonts.raleway(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.raleway(
            color: Color.fromARGB(255, 146, 138, 185), fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        isCollapsed: true,
      ),
    );
  }
}