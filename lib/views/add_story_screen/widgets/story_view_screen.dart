import 'dart:developer';
import 'package:buzztalk/views/add_story_screen/add_story_screen.dart';
import 'package:buzztalk/views/recent_chats/widgets/status_list/widgets/add_story_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/story_service.dart';

class StoryViewPage extends StatelessWidget {
  final List<Story> stories;
  final List<UserModel> usersWithStories;
  final int currentIndex;
  final auth = FirebaseAuth.instance;

  StoryViewPage({
    Key? key,
    required this.stories,
    required this.usersWithStories,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = StoryController();

    List<StoryItem> storyViewItems = stories.map((story) {
      if (story.mediaUrl != null) {
        log('${story.mediaUrl}');
        log('User Id : ${story.id}');
        return StoryItem.pageImage(
          controller: controller,
          url: story.mediaUrl!,
          caption: Text(
            story.userId ?? '',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 5),
        );
      } else {
        return StoryItem.text(
          title: story.id ?? '',
          textStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.black,
        );
      }
    }).toList();
    bool isCurrentUsersStory =
        usersWithStories[currentIndex].userId == auth.currentUser?.uid;
    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          StoryView(
            storyItems: storyViewItems,
            controller: controller,
            inline: false,
            repeat: false,
            onComplete: () async {
              int nextIndex = currentIndex + 1;
              if (nextIndex < usersWithStories.length) {
                UserModel nextUser = usersWithStories[nextIndex];
                List<Story> nextUserStories =
                    await StoryService().getStories(nextUser.userId!);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryViewPage(
                      stories: nextUserStories,
                      usersWithStories: usersWithStories,
                      currentIndex: nextIndex,
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          isCurrentUsersStory
              ? AddStoryButton(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStoryScreen(),
                      )),
                )
              : Container()
        ],
      ),
    );
  }
}
