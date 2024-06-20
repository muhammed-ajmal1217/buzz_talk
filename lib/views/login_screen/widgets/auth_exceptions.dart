  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void exceptionError(FirebaseAuthException user,BuildContext context) {
    String errorCode = '';
    errorCode = switch (user.code) {
      'wrong-password' => 'Incorrect password',
      'invalid-email' => 'Enter a valid e-mail',
      'user-not-found' => 'User not found',
      'invalid-credential' => 'Enter correct details',
      'user-disabled' => 'User not found',
      'channel-error' => 'Enter e-mail and password',
      _ => 'Incorrect email or password'
    };
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          errorCode,
          style: GoogleFonts.montserrat(color: Colors.black),
        )));
  }