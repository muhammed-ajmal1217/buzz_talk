import 'package:buzztalk/controller/image_controller.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_pick_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum IsStory { story, image }
class StorySelectDialogue extends StatelessWidget {
  IsStory story;
  StorySelectDialogue({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      actions: [
        Consumer2<StoryController,ImageControllers>(
          builder: (context, pro,pro1, child) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StoryPickButton(
                  icon: Iconsax.camera,
                  text: 'Camera',
                  onTap: () => _handlePick(pro,pro1,ImageSource.camera),
                ),
                StoryPickButton(
                  icon: Iconsax.gallery,
                  text: 'Gallery',
                  onTap: () => _handlePick(pro,pro1,ImageSource.gallery),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _handlePick(StoryController storyController,
      ImageControllers imageController, ImageSource source) {
    if (story == IsStory.story) {
      storyController.pickMedia(source);
    } else {
      imageController.pickImage(source);
    }
  }
}


