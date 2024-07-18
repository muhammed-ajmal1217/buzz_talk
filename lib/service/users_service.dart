import 'dart:developer';

import 'package:buzztalk/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UsersService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();
  UserModel? user;
  List<UserModel> users = [];

  Future<UserModel?> getCurrentUser() async {
    try {
      DocumentSnapshot userCredential = await firestore
          .collection('users')
          .doc(authentication.currentUser!.uid)
          .get();
      if (userCredential.exists) {
        user =
            UserModel.fromJson(userCredential.data() as Map<String, dynamic>);
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
    return user;
  }

  Future<Map<String, dynamic>> getAllUsers({
    DocumentSnapshot? lastDocument,
    int limit = 20,
  }) async {
    try {
      Query query = firestore.collection('users').orderBy('name').limit(limit);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      QuerySnapshot querySnapshot = await query.get();
      List<UserModel> users = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      DocumentSnapshot? lastDoc;
      if (querySnapshot.docs.isNotEmpty) {
        lastDoc = querySnapshot.docs.last;
      }
      return {'users': users, 'lastDocument': lastDoc};
    } catch (e) {
      log('Error while fetching getAllUsers: $e');
      return {'users': [], 'lastDocument': null};
    }
  }

    Future<List<String>> getFriendOrRequests(String key) async {
    final currentUserId = authentication.currentUser!.uid;
    try {
      DocumentSnapshot currentUserSnapshot = 
          await firestore.collection('users').doc(currentUserId).get();
      Map<String, dynamic>? currentUserData = 
          currentUserSnapshot.data() as Map<String, dynamic>?;
      return List<String>.from(currentUserData?[key] ?? []);
    } catch (e) {
      print('Error getting friend requests: $e');
      return [];
    }
  }


  Future<UserModel> getUser(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      return UserModel(
        userId: userId,
        userName: userData?['name'] ?? '',
        email: userData?['email'] ?? '',
        phoneNumber: userData?['phoneNumber'] ?? 0,
        about: userData?['about'] ?? '',
        profilePic: userData?['profile_pic'] ?? '',
      );
    } catch (e) {
      log('Error getting user data: $e');
      return UserModel();
    }
  }
}
