import 'dart:io';

import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_select_dialogue.dart';
import 'package:buzztalk/views/recent_chats/recent_chats.dart';
import 'package:buzztalk/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<StoryController>(context);
    final selectedMedia = pro.selectedMedia;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: selectedMedia != null
                      ? _isVideo(selectedMedia)
                          ? AssetImage(userIcon)
                          : FileImage(File(selectedMedia.path))
                      : AssetImage(userIcon)),
            ),
            child: selectedMedia != null && _isVideo(selectedMedia)
                ? VideoWidgetPlay(videoUrl: selectedMedia.path)
                : null,
          ),
          pro.selectedMedia != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () async {
                      final story = Story(
                          mediaUrl: pro.selectedMedia?.path,
                          userId: AuthenticationService()
                                  .authentication
                                  .currentUser
                                  ?.uid ??
                              '');
                      Provider.of<StoryController>(context, listen: false)
                          .uploadStory(context, story);
                      pro.selectedMedia = null;
                      await Future.delayed(Duration(seconds: 5));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatListPage(),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 233, 30, 220),
                          Color.fromARGB(255, 7, 6, 96),
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        'Add to Story',
                        style: GoogleFonts.montserrat(color: Colors.white),
                      )),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: pro.selectedMedia == null
          ? FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.1),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: CircleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StorySelectDialogue(story:IsStory.story);
                  },
                );
              })
          : null,
    );
  }

  bool _isVideo(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return extension == 'mp4' || extension == 'avi' || extension == 'mov';
  }
}
