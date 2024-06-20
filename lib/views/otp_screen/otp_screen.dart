import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/widgets/background_ellipse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  // String verificationId;
  // String name;
  // String phone;
  OtpScreen({
    super.key,
    // required this.verificationId,
    // required this.name,
    // required this.phone,
  });

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(children: [
          Ellipses(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.06,
                left: width * 0.05,
                right: width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  goBackArrow(context),
                  spacingHeight(width * 0.01),
                  spacingHeight(height * 0.02),
                  titlesofAuth(screenHeight: height, title: 'Enter the OTP'),
                  spacingHeight(height * 0.02),
                  Center(
                      child: Lottie.asset('assets/Animation - 1707475902081.json',
                          height: 240)),
                  spacingHeight(height * 0.02),
                  Center(
                      child: Text(
                    'Please enter the OTP number carefully',
                    style: TextStyle(color: Colors.white),
                  )),
                  spacingHeight(height * 0.02),
                  Center(
                    child: Pinput(
                      controller: otpController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          textStyle: TextStyle(fontSize: 17, color: Colors.white),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  spacingHeight(height * 0.04),
                  InkWell(
                      onTap: () {
                        // verifyOtp(context, otpController.text,phone);
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.90,
                        decoration: BoxDecoration(
                          color: Color(0xffFA7B06),
                          borderRadius: BorderRadius.circular(50),
            
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.020,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  // void verifyOtp(context, String userotp,String phonenumber) {
  //   final authPro=Provider.of<AuthenticationProvider>(context,listen: false);
  //   authPro.verifyOtp(
  //       verificationId: verificationId,
  //       otp: userotp,
  //       name: name,
  //       phone: phonenumber,
  //       onSuccess: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ChatListPage(),
  //             ));
  //       });
  // }
}
