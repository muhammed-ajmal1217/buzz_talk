
import 'dart:developer';

import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:buzztalk/service/friend_request_service.dart';
import 'package:flutter/material.dart';

class FriendConnectionController extends ChangeNotifier {
  AuthenticationService authService = AuthenticationService();
  bool _isFriendAccepted = false;
  bool get isFriendAccepted => _isFriendAccepted;
  late List<UserModel> filteredUsers = [];
  List<String> friendIds = [];
  List<UserModel>friends=[];
  bool isAccepted = false;
  getRequest() {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_request')
        .snapshots()
        .map((request) =>
            request.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  }

Stream<List<UserModel>> getFriends() {
  try {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_list')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  } catch (e) {
    print('Error fetching friends: $e');
    return Stream.empty();
  }
}
  Future<void> sendFriendRequest({
    String?targetUserId
  }) async {
    try {
      // FriendRequestService().sendFriendRequest(targetUserId!);
    } catch (e) {
      log('requesting Interrupted');
      throw Exception('requesting Interrupted : $e');
    }
    notifyListeners();
  }
}