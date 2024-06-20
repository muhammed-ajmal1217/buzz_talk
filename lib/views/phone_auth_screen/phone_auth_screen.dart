import 'package:buzztalk/controller/auth_provider.dart';
import 'package:buzztalk/controller/phone_auth_provider.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/views/otp_screen/otp_screen.dart';
import 'package:buzztalk/widgets/background_ellipse.dart';
import 'package:buzztalk/widgets/main_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhoneRequestPage extends StatefulWidget {
  const PhoneRequestPage({super.key});

  @override
  State<PhoneRequestPage> createState() => _PhoneRequestPageState();
}

class _PhoneRequestPageState extends State<PhoneRequestPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final phoneReqPro = Provider.of<PhoneAuthProvider>(context);
    phoneReqPro.phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneReqPro.phoneController.text.length));

    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(children: [
          Ellipses(),
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 50),
            child: goBackArrow(context),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Consumer<AuthenticationProvider>(
                  builder: (context, authPro, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacingHeight(height * 0.01),
                      titlesofAuth(
                          screenHeight: height,
                          title: 'Hello\nPlease Enter\nyour\nPhonenumber '),
                      spacingHeight(height * 0.02),
                      TextFormField(
                        controller: phoneReqPro.phoneController,
                        onChanged: (value) {},
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Enter your number',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: phoneReqPro.phoneController.text.length > 9
                                ? Icon(
                                    Icons.done_sharp,
                                    color: Colors.green,
                                  )
                                : null,
                            prefixIcon: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  showSearch: false,
                                  countryListTheme: CountryListThemeData(
                                      borderRadius: BorderRadius.circular(20),
                                      textStyle: GoogleFonts.raleway(color:Colors.white),
                                      searchTextStyle: TextStyle(
                                        backgroundColor: Colors.white,
                                          color: Colors.white,
                                          height: 0.5,
                                          decorationColor: Colors.white,
                                          fontStyle: FontStyle.italic),
                                      bottomSheetHeight: 500,
                                      backgroundColor:
                                          Color.fromARGB(255, 6, 36, 61)),
                                  context: context,
                                  onSelect: (newValue) {
                                    phoneReqPro.onselectValue(newValue);
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 16, bottom: 15, left: 15, right: 5),
                                child: Text(
                                  "${phoneReqPro.selectedCountry.flagEmoji}"
                                  '+'
                                  "${phoneReqPro.selectedCountry.phoneCode}",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )),
                      ),
                    
                      spacingHeight(height * 0.04),
                      MainButtons(
                          screenHeight: height,
                          screenWidth: width,
                          text: 'Send request',
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));
                          }),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
