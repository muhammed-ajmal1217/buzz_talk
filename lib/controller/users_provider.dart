import 'dart:developer';
import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier{
  UsersService usersService = UsersService();
  UserModel? currentUser;
  List<UserModel> _usersList = [];
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
    List<UserModel> get usersList => _usersList;
  bool get isLoading => _isLoading;

  Future<void> getCurrentUser()async{
    try {
      currentUser = await usersService.getCurrentUser();
      notifyListeners();
    } catch (e) {
      log('Error on fetching user :$e');
      throw Exception('Error on fetching users :$e');
    }
  }
  
  Future<void> fetchUsers({bool isLoadMore = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      if (currentUser == null) {
        await getCurrentUser();
      }
      Map<String, dynamic> result = await usersService.getAllUsers(
        lastDocument: _lastDocument,
      );
      List<UserModel> newUsers = result['users'];
      DocumentSnapshot? lastDoc = result['lastDocument'];
      newUsers = newUsers.where((user)=>user.userId!=currentUser?.userId).toList();

      if (newUsers.isNotEmpty) {
        _usersList.addAll(newUsers);
        _lastDocument = lastDoc;
      }
    } catch (e) {
      log('Error while fetching users in provider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetUsers() {
    _usersList = [];
    _lastDocument = null;
    notifyListeners();
  }
}