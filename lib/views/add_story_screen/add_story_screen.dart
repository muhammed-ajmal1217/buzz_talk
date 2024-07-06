import 'dart:io';

import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:buzztalk/service/story_service.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_select_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
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
                  image: pro.selectedImage != null
                      ? FileImage(File(pro.selectedImage?.path??''))
                      : AssetImage(userIcon)),
            ),
          ),
          pro.selectedImage!=null?
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                final story = Story(imageUrl: pro.selectedImage?.path, userId: AuthenticationService().authentication.currentUser?.uid??'');
                StoryService().uploadImageStory(story);
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
                child: Center(child: Text('Add to Story',style: GoogleFonts.montserrat(color: Colors.white),)),
              ),
            ),
          ):Container(),
      ],
      ),
     floatingActionButton:pro.selectedImage==null?  
     FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.1),
        child: Icon(Icons.add,color: Colors.white,),
          shape: CircleBorder(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return StorySelectDialogue();
              },
            );
          }):null,
    );
  }
}




