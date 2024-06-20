import 'dart:developer';
import 'package:buzztalk/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();

  signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential user = await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (error) {
      log('Signin');
      return error;
    }
  }

  signupWithEmail(
      {required String email,
      required BuildContext context,
      required String password,
      required String userName}) async {
    try {
      UserCredential user = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userData =
          UserModel(email: email, userName: userName, userId: user.user?.uid);
      firestore.collection('users').doc(user.user?.uid).set(userData.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  signout() async {
    try {
      await authentication.signOut();
    } catch (e) {
      throw Exception('couldnt signout because$e');
    }
  }
}
