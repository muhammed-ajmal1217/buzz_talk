import 'dart:developer';
import 'package:buzztalk/controller/auth_provider.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/login_screen/widgets/auth_exceptions.dart';
import 'package:buzztalk/views/phone_auth_screen/phone_auth_screen.dart';
import 'package:buzztalk/widgets/auth_button.dart';
import 'package:buzztalk/widgets/background_ellipse.dart';
import 'package:buzztalk/widgets/main_button.dart';
import 'package:buzztalk/widgets/snack_bar.dart';
import 'package:buzztalk/widgets/toggle_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUp;

  LoginPage({Key? key, required this.showSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Color(0xff03091F),
        child: Stack(
          children: [
            Ellipses(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Consumer<AuthenticationProvider>(
                    builder: (context, authProvider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spacingHeight(screenHeight * 0.01),
                        titlesofAuth(
                            screenHeight: screenHeight * 0.9,
                            title: "Lets Start"),
                        subTitleAuth(
                            screenHeight: screenHeight * 0.9,
                            title:
                                "Login with your email and password to \ncontinue."),
                        spacingHeight(screenHeight * 0.02),
                        textFields(
                            controller: emailController,
                            text: 'E-mail',
                            fontSize: 13),
                        spacingHeight(screenHeight * 0.03),
                        textFields(
                            controller: passwordController,
                            text: 'Password',
                            fontSize: 13),
                        spacingHeight(screenHeight * 0.01),
                        InkWell(
                          onTap: () {},
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  color: Color(0xff02B4BF), fontSize: 13),
                            ),
                          ),
                        ),
                        spacingHeight(screenHeight * 0.02),
                        MainButtons(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            text: 'Login',
                            onPressed: () async {
                              final user = await authProvider.signinWithEmail(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context);
                              if (user is UserCredential) {
                                snackBarWidget(context, 'Login Successful');
                              } else if (user is FirebaseAuthException) {
                                log(user.code);
                                exceptionError(user, context);
                              }
                            }),
                        spacingHeight(screenHeight * 0.01),
                        ToggleScreen(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          text1: 'Create New Account',
                          text2: 'Sign up',
                          toggleScreen: () => widget.showSignUp(),
                        ),
                        spacingHeight(screenHeight * 0.010),
                        Center(
                          child: Text(
                            '__________________________ OR __________________________',
                            style: TextStyle(
                                color: Color.fromARGB(255, 116, 115, 115),
                                fontSize: screenHeight * 0.013),
                          ),
                        ),
                        spacingHeight(screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AuthButtons(
                              image: 'assets/facebook_icon_png.png',
                              screenHeight: screenHeight,
                              onPressed: () async {},
                            ),
                            AuthButtons(
                              screenHeight: screenHeight,
                              image: 'assets/google_icon_png.png',
                              onPressed: () {},
                            ),
                            AuthButtons(
                              screenHeight: screenHeight,
                              image: 'assets/mobile_png.png',
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PhoneRequestPage(),
                                ));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
