import 'package:buzztalk/views/all_users/all_users_screen.dart';
import 'package:buzztalk/views/friends_and_request/friends_and_request_screen.dart';
import 'package:flutter/material.dart';

class NavigateToFriends extends StatelessWidget {
  NavigateToFriends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Friends_RequestPage(),));
      },
      backgroundColor: Color.fromARGB(255, 170, 122, 247),
      shape: CircleBorder(),
      child: Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}
