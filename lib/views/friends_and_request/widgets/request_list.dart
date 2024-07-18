import 'dart:developer';
import 'package:buzztalk/constants/app_colors.dart';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/friend_accept_service.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsRequest extends StatefulWidget {
  FriendsRequest({Key? key, e});

  @override
  State<FriendsRequest> createState() => _FriendsRequestState();
}

class _FriendsRequestState extends State<FriendsRequest> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<List<String>>(
        future: UsersService().getFriendOrRequests('friend_requests'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading friend requests',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No request',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            List<String> requestList = snapshot.data!;
            return ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                String requestId = requestList[index];
                return FutureBuilder<UserModel>(
                  future: UsersService().getUser(requestId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (userSnapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading user data',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (!userSnapshot.hasData) {
                      return Center(
                        child: Text(
                          'User not found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      UserModel request = userSnapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 33, 43, 61).withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                request.userName ?? '',
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              leading: GestureDetector(
                                onTap: () {},
                                child: Hero(
                          tag: index,
                          child: CircleAvatar(
                            backgroundImage: request.profilePic != null &&
                                        request.profilePic!.isNotEmpty
                                    ? NetworkImage(request.profilePic!)
                                    : AssetImage(userIcon) as ImageProvider,
                          )
                          // Container(
                          //   height: size.height * 0.065,
                          //   width: size.height * 0.065,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: 
                          //     ),
                          //   ),
                          // ),
                        ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  requestAccept_Reject(Icons.check, height, () async {
                                    bool success = await FriendAcceptService().acceptFriendRequest(requestId);
                                    if (success) {
                                      setState(() {});
                                    }
                                    log('Clicked');
                                  }),
                                  SizedBox(width: width * 0.03),
                                  requestAccept_Reject(Icons.close, height, () async {
                                    
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}