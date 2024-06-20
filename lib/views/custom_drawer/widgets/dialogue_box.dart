import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/custom_drawer/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<dynamic> addDetailsDialogue(
    BuildContext context,
    FirebaseAuth auth,
    TextEditingController emailController,
    TextEditingController dobController,
    TextEditingController phoneController,
    TextEditingController aboutController,
    ) {
  return showDialog(
    context: context,
    builder: (context) {
      var textButtonStyle =
      GoogleFonts.raleway(color: const Color.fromARGB(255, 33, 219, 243));
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 20, 27, 39),
        title: Text(
          'Add Details',
          style: GoogleFonts.raleway(color: Colors.white),
        ),
        actions: [
          MoreDetailsTextWidgets(
            auth: auth,
            hintText: auth.currentUser?.email ?? 'Email',
            controller: emailController,
            keyboardType: TextInputType.name,
          ),
          spacingHeight(10),
          MoreDetailsTextWidgets(
            auth: auth,
            hintText: 'DOB: eg-17/12/1999',
            controller: dobController,
            keyboardType: TextInputType.name,
          ),
          spacingHeight(10),
          MoreDetailsTextWidgets(
            auth: auth,
            hintText: auth.currentUser?.phoneNumber ?? 'Phone',
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
          spacingHeight(10),
          MoreDetailsTextWidgets(
            auth: auth,
            hintText: 'About',
            controller: aboutController,
            keyboardType: TextInputType.text,
            maxLines: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'save',
                  style: textButtonStyle,
                ),
              ),
              spacingWidth(20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: textButtonStyle,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
