import 'package:buzztalk/views/all_users/all_users_screen.dart';
import 'package:flutter/material.dart';

class NavigateToFriends extends StatelessWidget {
  NavigateToFriends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsSuggestions(),));
      },
      backgroundColor: Color(0xff02B4BF),
      shape: CircleBorder(),
      child: Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}
