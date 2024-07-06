import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_pick_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StorySelectDialogue extends StatelessWidget {
  const StorySelectDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      actions: [
        Consumer<StoryController>(
          builder: (context, pro, child) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StoryPickButton(
                  icon: Iconsax.camera,
                  text: 'Camera',
                  onTap: () => pro.pickImage(ImageSource.camera),
                ),
                StoryPickButton(
                  icon: Iconsax.gallery,
                  text: 'Gallery',
                  onTap: () => pro.pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}