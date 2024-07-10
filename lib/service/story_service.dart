import 'dart:developer';
import 'dart:io';
import 'package:buzztalk/model/story_model.dart';
import 'package:buzztalk/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StoryService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Story> stories = [];
  List<UserModel> usersWithStories = [];

  Future<void> uploadStory(Story story) async {
    try {
      String uid = _auth.currentUser!.uid;
      CollectionReference storiesCollection =
          _firestore.collection('users').doc(uid).collection('stories');
      String mediaPath = story.mediaUrl!;
      Reference storageRef;
      if (mediaPath.endsWith('.jpg') || mediaPath.endsWith('.jpeg') || mediaPath.endsWith('.png')) {
        storageRef = _storage
            .ref()
            .child('user_stories')
            .child(uid)
            .child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");
      } else if (mediaPath.endsWith('.mp4')) {
        storageRef = _storage
            .ref()
            .child('user_stories')
            .child(uid)
            .child("${DateTime.now().millisecondsSinceEpoch.toString()}.mp4");
      } else {
        throw Exception('Unsupported media format');
      }

      UploadTask uploadTask = storageRef.putFile(File(story.mediaUrl!));
      TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      String storyId = _firestore.collection('stories').doc().id;
      await storiesCollection.doc(storyId).set({
        'mediaUrl': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      log('Media uploaded successfully!');
    } catch (e) {
      log('Error uploading media: $e');
    }
  }

Future<List<UserModel>> getUsersWithStories({required List<String> friends}) async {
  try {
    String currentUserId = _auth.currentUser!.uid;
    
    QuerySnapshot currentUserStoriesSnapshot = await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('stories')
        .get();

    if (currentUserStoriesSnapshot.docs.isNotEmpty) {
      friends.insert(0, currentUserId);
      DocumentSnapshot currentUserSnapshot = await _firestore
          .collection('users')
          .doc(currentUserId)
          .get();

      if (currentUserSnapshot.exists) {
        var currentUserModel = UserModel.fromJson(
            currentUserSnapshot.data() as Map<String, dynamic>);
        usersWithStories.add(currentUserModel);
      } else {
        log('Current user snapshot does not exist for userId: $currentUserId');
      }
    }

    Set<String> uniqueUserIds = {if (currentUserStoriesSnapshot.docs.isNotEmpty) currentUserId};
    QuerySnapshot querySnapshot = await _firestore.collectionGroup('stories').get();
    for (var doc in querySnapshot.docs) {
      String userId = doc.reference.parent.parent!.id;
      if (friends.contains(userId) && !uniqueUserIds.contains(userId)) {
        uniqueUserIds.add(userId);
        DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
        if (userSnapshot.exists) {
          var userModel = UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
          usersWithStories.add(userModel);
        } else {
          log('User snapshot does not exist for userId: $userId');
        }
      }
    }

    return usersWithStories;
  } catch (e) {
    log('Error fetching users with stories: $e');
    return [];
  }
}




  Future<List<Story>> getStories(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('stories')
          .get();
      log('Query Snapshot: ${querySnapshot.docs.length}');

      List<Story> stories = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        log('Document Data: $data');
        return Story.fromJson(data);
      }).toList();

      log('Story List: ${stories.length}');
      return stories;
    } catch (e) {
      print('Error fetching stories: $e');
      return [];
    }
  }
}
