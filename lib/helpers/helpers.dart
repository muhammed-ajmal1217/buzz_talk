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
      fontWeight: FontWeight.w500,
      fontSize: screenHeight * 0.050,
    ),
  );
}
Text subTitleAuth({required double screenHeight, required String title}) {
  return Text(
    title,
    style: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: screenHeight * 0.015,
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
InkWell requestAccept_Reject(IconData icon,double height,VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: CircleAvatar(
            radius: height*0.02,
            backgroundColor: Color.fromARGB(163, 255, 255, 255).withOpacity(0.07),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        )),
  );
}

Row tabBarContent({required IconData icon, required String text,required double height}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon),
      spacingWidth(height*0.01),
      Text(text),
    ],
  );
}
