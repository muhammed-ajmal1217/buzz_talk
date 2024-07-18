import 'dart:developer';

import 'package:buzztalk/constants/app_colors.dart';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:buzztalk/views/chat_screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FriendsList extends StatefulWidget {
  FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<List<UserModel>>? _friendsFuture;
  List<UserModel>? _friendsList;

  @override
  void initState() {
    super.initState();
    _friendsFuture = _fetchFriendsData();
  }

  Future<List<UserModel>> _fetchFriendsData() async {
    List<String> friendIds =
        await UsersService().getFriendOrRequests('friends');
    List<UserModel> friends = [];
    for (String id in friendIds) {
      UserModel? user = await UsersService().getUser(id);
      if (user != null) {
        friends.add(user);
      }
    }
    return friends;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: FutureBuilder<List<UserModel>>(
        future: _friendsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading friend requests',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No request',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            _friendsList = snapshot.data!;
            return SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.separated(
                itemCount: _friendsList!.length,
                itemBuilder: (context, index) {
                  UserModel friend = _friendsList![index];
                  return ListTile(
                    title: Text(
                      friend.userName ?? '',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                      },
                      child: Hero(
                          tag: index,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: friend.profilePic != null &&
                                    friend.profilePic!.isNotEmpty
                                ? NetworkImage(friend.profilePic!)
                                : AssetImage(userIcon) as ImageProvider,
                          )),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                user: friend,
                              ),
                            ));
                          },
                          child: Icon(
                            Iconsax.message,
                            color: Color.fromARGB(255, 10, 213, 189),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Icon(
                          Iconsax.profile_delete,
                          color: Color.fromARGB(255, 244, 79, 54),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.white);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
