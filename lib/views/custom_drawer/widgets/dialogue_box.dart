import 'dart:developer';
import 'dart:io';
import 'package:buzztalk/constants/user_icon.dart';
import 'package:buzztalk/controller/drawer_controller.dart';
import 'package:buzztalk/controller/image_controller.dart';
import 'package:buzztalk/controller/story_controller.dart';
import 'package:buzztalk/helpers/helpers.dart';
import 'package:buzztalk/service/edit_profile_service.dart';
import 'package:buzztalk/views/add_story_screen/add_story_screen.dart';
import 'package:buzztalk/views/add_story_screen/widgets/story_select_dialogue.dart';
import 'package:buzztalk/views/custom_drawer/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddDetailsDialog extends StatelessWidget {
  final FirebaseAuth? auth;

  AddDetailsDialog({
    Key? key,
    this.auth,
  }) : super(key: key);


  Future<void> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DrawerControllers>(context,listen: false);
    var textButtonStyle =
        GoogleFonts.raleway(color: const Color.fromARGB(255, 33, 219, 243));

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 20, 27, 39),
      title: Text(
        'Add Details',
        style: GoogleFonts.raleway(color: Colors.white),
      ),
      actions: [
        Center(
          child: Column(
            children: [
              Consumer<ImageControllers>(
                builder: (context, pro, child) => CircleAvatar(
                  backgroundImage: pro.selectedImage != null
                      ? FileImage(File(pro.selectedImage?.path ?? ''))
                      : AssetImage(userIcon) as ImageProvider,
                  radius: 30,
                ),
              ),
              InkWell(
                onTap: () async {
                  await _requestStoragePermission();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return  StorySelectDialogue(story: IsStory.image,);
                    },
                  );
                },
                child: const Text(
                  '+Add',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        MoreDetailsTextWidgets(
          auth: auth!,
          hintText: auth!.currentUser?.email ?? 'Email',
          controller:pro.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        spacingHeight(10),
        // TextField(
        //       controller: pro.dobController,
        //       decoration: InputDecoration(
        //         labelText: 'Date of Birth',
        //         suffixIcon: IconButton(
        //           icon: Icon(Icons.calendar_today),
        //           onPressed: () => pro.selectDate(context),
        //         ),
        //       ),
        //       readOnly: true,
        //     ),
        spacingHeight(10),
        MoreDetailsTextWidgets(
          auth: auth!,
          hintText: auth!.currentUser?.phoneNumber != null
              ? auth!.currentUser!.phoneNumber.toString()
              : 'Phone',
          controller: pro.phoneController,
          keyboardType: TextInputType.phone,
        ),
        spacingHeight(10),
        MoreDetailsTextWidgets(
          auth: auth!,
          hintText: 'About',
          controller: pro.aboutController,
          keyboardType: TextInputType.text,
          maxLines: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
               final drawerPro= Provider.of<DrawerControllers>(context, listen: false);
               final imagePro= Provider.of<ImageControllers>(context, listen: false);
                   drawerPro .editProfile(
                        context: context,
                        selectedImage:imagePro.selectedImage,
                        );
              },
              child: Text(
                'Save',
                style: textButtonStyle,
              ),
            ),
            spacingWidth(20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: textButtonStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
