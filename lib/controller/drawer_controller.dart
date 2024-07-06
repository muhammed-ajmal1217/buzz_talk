import 'dart:io';

import 'package:buzztalk/service/edit_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DrawerControllers extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  // DrawerControllers _drawerControllers = DrawerControllers();
  // DateTime? _selectedDate;
  void editProfile({
    required BuildContext context,
    required File? selectedImage,
  }) async {
    try {
      final String name = nameController.text.trim();
      final String about = aboutController.text.trim();
      final String email = emailController.text.trim();
      final String phone = phoneController.text.trim();
      final String dob = dobController.text.trim();
      int? phoneNumber;
      if (phone.isNotEmpty) {
        phoneNumber = int.tryParse(phone);
        if (phoneNumber == null) {
          throw FormatException("Invalid phone number");
        }
      }

      DateTime? dateOfBirth;
      if (dob.isNotEmpty) {
        dateOfBirth = DateTime.tryParse(dob);
        if (dateOfBirth == null) {
          throw FormatException("Invalid date format");
        }
      }

      String? profilePicURL;
      if (selectedImage != null) {
        final profilePicPath = selectedImage.path;
        final profilePicFile = File(profilePicPath);
        profilePicURL =
            await EditProfileService().uploadProfilePicture(profilePicFile);
      }

      Map<String, dynamic> updatedFields = {};
      if (name.isNotEmpty) updatedFields['name'] = name;
      if (about.isNotEmpty) updatedFields['about'] = about;
      if (email.isNotEmpty) updatedFields['email'] = email;
      if (phoneNumber != null) updatedFields['phone_number'] = phoneNumber;
      if (dateOfBirth != null)
        updatedFields['dob'] = dateOfBirth.toIso8601String();
      if (profilePicURL != null) updatedFields['profile_pic'] = profilePicURL;

      await EditProfileService().updateCurrentUser(updatedFields);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
    notifyListeners();
  }

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     _selectedDate = picked;
  //     _drawerControllers.dobController.text =
  //         DateFormat('MM/dd/yyyy').format(picked);
  //   }
  //   notifyListeners();
  // }
}
