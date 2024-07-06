import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/users_provider.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:buzztalk/views/custom_drawer/widgets/dialogue_box.dart';
import 'package:buzztalk/views/custom_drawer/widgets/list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthenticationService service = AuthenticationService();
  FirebaseAuth auth = FirebaseAuth.instance;
  late UsersProvider usersProvider;

  var textButtonStyle =
      GoogleFonts.raleway(color: const Color.fromARGB(255, 33, 219, 243));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    usersProvider.getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      surfaceTintColor: Colors.black,
      backgroundColor: Color.fromARGB(255, 19, 25, 35),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 20, 27, 39),
            ),
            child: Consumer<UsersProvider>(
              builder: (context, authPro, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: size.width * 0.065,
                          backgroundColor: Colors.transparent,
                          backgroundImage: authPro.currentUser?.profilePic !=
                                  null
                              ? NetworkImage(authPro.currentUser!.profilePic!)
                              : AssetImage(userIcon) as ImageProvider),
                      spacingWidth(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            authPro.currentUser?.userName ?? 'Loading...',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: size.width * 0.040,
                            ),
                          ),
                          Text(
                            authPro.currentUser?.email ?? 'Loading...',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: size.width * 0.020,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  spacingHeight(size.height * 0.00),
                  Text(
                    'Ph: ${authPro.currentUser?.phoneNumber?.toString() ?? 'Loading...'}',
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 10),
                  ),
                  spacingHeight(size.height * 0.001),
                  // Text(
                  //   'DOB: ${authPro.currentUser?.dob != null ? DateFormat('MM/dd/yyyy').format(authPro.currentUser!.dob!) : 'Loading...'}',
                  //   style: GoogleFonts.montserrat(
                  //       color: Colors.white, fontSize: 10),
                  // ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddDetailsDialog(
                              auth: auth,
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 37, 47, 65),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Iconsax.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTiles(
            text: 'Terms & Conditions',
            onTap: () {},
          ),
          ListTiles(
            text: 'Profile',
            onTap: () {},
          ),
          ListTiles(
            text: "Favourite chat's",
            onTap: () {},
          ),
          ListTiles(
            text: 'Logout',
            onTap: () {
              AuthenticationService().signout();
            },
          ),
          ListTiles(
            text: 'F A Q?',
            onTap: () {},
          ),
          ListTiles(
            text: 'Delete my Account',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
