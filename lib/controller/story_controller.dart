import 'dart:developer';
import 'dart:io';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/story_service.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoryController extends ChangeNotifier {
  final imagePicker = ImagePicker();
  File? selectedMedia;
  List<UserModel> usersWithStories = [];
  bool isLoading = true;
  bool isLoadingCurrentUser = true;
  StoryService storyService = StoryService();

  Future<void> pickMedia(ImageSource source) async {
    final pickerFile = await (source == ImageSource.camera
        ? imagePicker.pickImage(
            source: source, preferredCameraDevice: CameraDevice.rear)
        : imagePicker.pickImage(source: source));

    final pickerVideoFile = await (source == ImageSource.camera
        ? imagePicker.pickVideo(
            source: source, preferredCameraDevice: CameraDevice.rear)
        : imagePicker.pickVideo(source: source));

    if (pickerFile != null) {
      selectedMedia = File(pickerFile.path);
    } else if (pickerVideoFile != null) {
      selectedMedia = File(pickerVideoFile.path);
    } else {
      selectedMedia = null;
    }

    notifyListeners();
  }

  Future<void> uploadStory(BuildContext context,Story story) async {
    if (selectedMedia == null) {
      return;
    }
    try {
      await storyService.uploadStory(story);
      selectedMedia = null;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story uploaded successfully')),
      );
    } catch (e) {
      log('Error uploading story: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading story: $e')),
      );
    }
  }

  Future<void> fetchUsersWithStories() async {
    try {
      StoryService storyService = StoryService();
      List<String> friends =
          await UsersService().getFriendOrRequests('friends');
      List<UserModel> friendsWithStories =
          await storyService.getUsersWithStories(friends: friends);
      usersWithStories = friendsWithStories;
    } catch (e) {
      print('Error fetching users with stories: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
