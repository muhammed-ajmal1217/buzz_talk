import 'package:buzztalk/constants/app_colors.dart';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/users_provider.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/friend_request_service.dart';
import 'package:buzztalk/views/user_details_screen/user_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersContainer extends StatelessWidget {
  final UserModel user;
  final UsersProvider provider;
  
  UsersContainer({Key? key, required this.user, required this.provider}) : super(key: key);

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
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(user: user,),));
                  },
                  child: Hero(
                    tag: user.userId??'',
                    child: Container(
                      height: height * 0.085,
                      width: height * 0.085,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 40, 49, 62),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: user.profilePic != null &&
                                    user.profilePic!.isNotEmpty
                                ? NetworkImage(user.profilePic!)
                                : AssetImage(userIcon) as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  '${user.userName}',
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.01),
                InkWell(
                  onTap: () async {
                    bool success = await FriendRequestService().sendFriendRequest(user.userId??'');
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Friend request sent')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to send friend request')),
                      );
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: orange,
                    ),
                    child: Center(
                      child: Text(
                        'Add Friend',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                        ),
                      ),
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
