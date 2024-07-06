import 'dart:developer';

import 'package:buzztalk/views/add_story_screen/widgets/gradient_border_paint.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/story_service.dart';

class StoryViewPage extends StatefulWidget {
  final List<Story> stories;
  final List<UserModel> usersWithStories;
  final int currentIndex;

  const StoryViewPage({
    Key? key,
    required this.stories,
    required this.usersWithStories,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = StoryController();

    List<StoryItem> storyViewItems = widget.stories.map((story) {
      if (story.imageUrl != null) {
        log('${story.imageUrl}');
        return StoryItem.pageImage(
          controller: controller,
          url: story.imageUrl!,
          caption: Text(story.textContent ?? ''),
          duration: Duration(seconds: 5),
        );
      } else {
        return StoryItem.text(
          title: story.textContent ?? '',
          backgroundColor: Colors.black,
        );
      }
    }).toList();

    return Material(
      child: Stack(
        children: [
          StoryView(
            storyItems: storyViewItems,
            controller: controller,
            inline: false,
            repeat: false,
            onComplete: () async {
              int nextIndex = widget.currentIndex + 1;
              if (nextIndex < widget.usersWithStories.length) {
                UserModel nextUser = widget.usersWithStories[nextIndex];
                List<Story> nextUserStories = await StoryService().getStories(nextUser.userId!);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryViewPage(
                      stories: nextUserStories,
                      usersWithStories: widget.usersWithStories,
                      currentIndex: nextIndex,
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
