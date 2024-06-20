import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendConnection {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> sendFriendRequest(String targetUserId) async {
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

          List<String> friendRequests;
          if (targetUserData != null &&
              targetUserData.containsKey('friend_requests')) {
            friendRequests =
                List<String>.from(targetUserData['friend_requests']);
          } else {
            friendRequests = [];
          }
          if (!friendRequests.contains(currentUserId)) {
            friendRequests.add(currentUserId);
            transaction
                .update(targetUserRef, {'friend_requests': friendRequests});
          }
        }
      });
    } catch (e) {
      print('Error sending friend request: $e');
      throw Exception('Error sending friend request: $e');
    }
  }
}
