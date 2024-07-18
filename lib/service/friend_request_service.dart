import 'package:buzztalk/model/user_model.dart';
import 'package:buzztalk/service/users_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendRequestService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UsersService usersService = UsersService();

  Future<bool> sendFriendRequest(String targetUserId) async {
    final currentUserId = auth.currentUser!.uid;
    try {
      DocumentReference targetUserRef =
          firestore.collection('users').doc(targetUserId);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot targetUserSnapshot =
            await transaction.get(targetUserRef);

        if (targetUserSnapshot.exists) {
          Map<String, dynamic>? targetUserData =
              targetUserSnapshot.data() as Map<String, dynamic>?;
          List<String> friendRequests =
              targetUserData?['friend_requests'] != null
                  ? List<String>.from(targetUserData!['friend_requests'])
                  : [];

          if (!friendRequests.contains(currentUserId)) {
            friendRequests.add(currentUserId);
            transaction
                .update(targetUserRef, {'friend_requests': friendRequests});
          }
        }
      });
      return true;
    } catch (e) {
      print('Error sending friend request: $e');
      return false;
    }
  }
}
