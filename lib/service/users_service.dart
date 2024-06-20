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
      log('Error while fetching users: $e');
      return {'users': [], 'lastDocument': null};
    }
  }
}
