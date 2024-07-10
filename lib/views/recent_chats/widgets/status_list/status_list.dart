import 'dart:developer';

import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/helpers/helpers.dart';
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
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryController>(
      builder: (context, pro, child) {
        bool currentUserHasStory = auth.currentUser != null &&
            pro.usersWithStories
                .any((user) => user.userId == auth.currentUser!.uid);

        List<UserModel> usersWithStoriesExcludingCurrentUser = pro
            .usersWithStories
            .where((user) => user.userId != auth.currentUser?.uid)
            .toList();

        return pro.isLoading
            ? Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          1 + usersWithStoriesExcludingCurrentUser.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          if (currentUserHasStory) {
                            final currentUserStory = pro.usersWithStories
                                .firstWhere((user) =>
                                    user.userId == auth.currentUser!.uid);
                            return StoryCircle(
                              user: currentUserStory,
                              pro: pro,
                              index: index,
                              context: context,
                            );
                          } else {
                            return Column(
                              children: [
                                AddStoryButton(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddStoryScreen(),
                                    ),
                                  ),
                                ),
                                spacingHeight(5),
                                Text(
                                  'Add Story',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            );
                          }
                        } else {
                          final user =
                              usersWithStoriesExcludingCurrentUser[index - 1];
                          return StoryCircle(
                            user: user,
                            pro: pro,
                            index: index,
                            context: context,
                          );
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
