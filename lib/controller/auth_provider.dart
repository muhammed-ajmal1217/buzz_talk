import 'package:buzztalk/service/auth_service.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationService authService = AuthenticationService();

  signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      return await authService.signinWithEmail(
          email: email, password: password, context: context);
    } catch (e) {
      throw Exception('Signin with Email has error because$e');
    }
  }
  
  signupWithEmail(
      {required String email,
      required String password,
      required BuildContext context,
      required String userName}) async {
    try {
      await authService.signupWithEmail(
          email: email, password: password, userName: userName,context: context);
    } catch (e) {
      throw Exception('error signup becauase$e');
    }
    notifyListeners();
  }
    signOut() async {
    try {
      await authService.signout();
    } catch (e) {
      throw Exception('error sign out becauase$e');
    }
    notifyListeners();
  }
}

