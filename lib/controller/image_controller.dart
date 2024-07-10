import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageControllers extends ChangeNotifier{
  final imagePicker = ImagePicker();
  File? selectedImage;
    Future<void> pickImage(ImageSource source) async {
    final pickerFile = await imagePicker.pickImage(source: source);
    if (pickerFile != null) {
      selectedImage = File(pickerFile.path);
      notifyListeners();
    }
    }
}