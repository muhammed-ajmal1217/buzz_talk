import 'package:buzztalk/constants/app_colors.dart';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/users_provider.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/friend_request_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersContainer extends StatelessWidget {
  UserModel user;
  UsersProvider provider;
  UsersContainer({super.key,required this.user,required this.provider});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 33, 43, 61).withOpacity(0.5),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 56, 80).withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Hero(
                    tag: user,
                    child: Container(
                      height: height * 0.085,
                      width: height * 0.085,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 40, 49, 62),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(userIcon),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  ' ${user.userName}',
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.01),
                InkWell(
                  onTap: () async {
                    FriendRequestService().sendFriendRequest(user.userId!);
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: orange,
                    ),
                    child: Center(
                      child: Text('Add Friend'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}