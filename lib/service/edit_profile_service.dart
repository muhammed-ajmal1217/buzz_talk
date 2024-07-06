import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileService{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
Future<void> updateCurrentUser(Map<String, dynamic> updatedFields) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(updatedFields);
    log('User data updated successfully');
  } catch (e) {
    log('Error updating user data: $e');
  }
}
Future<String?> uploadProfilePicture(File imageFile) async {
  try {
    final storageRef = storage
        .ref()
        .child('profile_pictures')
        .child(auth.currentUser!.uid);
    final uploadTask = storageRef.putFile(imageFile);
    final taskSnapshot = await uploadTask.whenComplete(() {});
    final downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    log('Error uploading profile picture: $e');
    return null;
  }
}


}