import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SizedBox spacingHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox spacingWidth(double width) {
  return SizedBox(
    width: width,
  );
}

TextFormField textFields({
  required String text,
  required double fontSize,
  TextEditingController? controller, 
}) {
  return TextFormField(
    style: TextStyle(fontSize: fontSize,color: Colors.white),
    controller: controller,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(fontSize: fontSize, color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Text titlesofAuth({required double screenHeight, required String title}) {
  return Text(
    title,
    style: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: screenHeight * 0.040,
    ),
  );
}

InkWell goBackArrow(BuildContext context) {
  return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ));
}