
import 'package:buzztalk/controller/login_provider.dart';
import 'package:buzztalk/views/login_screen/login_screen.dart';
import 'package:buzztalk/views/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.showLogin) {
      return LoginPage(
        showSignUp: loginProvider.toggleScreen,
      );
    } else {
      return SignUpPage(
        showLogin: loginProvider.toggleScreen,
      );
    }
  }
}
