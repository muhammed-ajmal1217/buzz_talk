import 'dart:developer';

import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/views/add_story_screen/add_story_screen.dart';
import 'package:buzztalk/views/recent_chats/widgets/status_list/widgets/add_story_button.dart';
import 'package:buzztalk/views/recent_chats/widgets/status_list/widgets/status_circle_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusList extends StatefulWidget {
  final double width;

  const StatusList({Key? key, required this.width}) : super(key: key);

  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
     @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pro = Provider.of<StoryController>(context, listen: false);
    pro.fetchUsersWithStories();
    pro.fetchCurrentUser();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    

    return Consumer<StoryController>(
      builder: (context, pro, child) {
        bool currentUserHasStory = pro.currentUser != null &&
        pro.usersWithStories.any((user) => user.userId == pro.currentUser!.userId);
        return pro.isLoadingCurrentUser || pro.isLoading
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pro.usersWithStories.length+1,
                    itemBuilder: (context, index) {
                        log('${pro.currentUser!.userName}');
                      if (index == 0) {
                        if(currentUserHasStory){
                          return StoryCircle(
                            user: pro.currentUser??UserModel(),
                            pro: pro,
                            index: index,
                            context: context,
                          );
                        }else{
                          return AddStoryButton(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddStoryScreen()),
                          ),
                        );
                        }
                        
                      } else {
                        final userIndex = currentUserHasStory ? index : index - 1;
                        if (userIndex < pro.usersWithStories.length) {
                          final user = pro.usersWithStories[userIndex];
                          return StoryCircle(
                            user: user,
                            pro: pro,
                            index: index,
                            context: context,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                    },
                  ),
                ),
              ],
            );
      },
    );
  }
}
