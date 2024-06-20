import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void snackBarWidget(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: GoogleFonts.montserrat(color: Colors.black),
      )));
}
