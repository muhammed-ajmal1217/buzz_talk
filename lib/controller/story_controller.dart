import 'dart:developer';
import 'dart:io';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/story_service.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoryController extends ChangeNotifier {
  final imagePicker = ImagePicker();
  File? selectedImage;
  List<UserModel> usersWithStories = [];
  bool isLoading = true;
  UserModel? currentUser;
  bool isLoadingCurrentUser = true;
  Future<void> pickImage(ImageSource source) async {
    final pickerFile = await imagePicker.pickImage(source: source);
    if (pickerFile != null) {
      selectedImage = File(pickerFile.path);
      notifyListeners();
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
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching users with stories: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentUser() async {
    UserModel? fetchedUser = await UsersService().getCurrentUser();
    currentUser = fetchedUser;
    isLoadingCurrentUser = false;
    notifyListeners();
  }
}
