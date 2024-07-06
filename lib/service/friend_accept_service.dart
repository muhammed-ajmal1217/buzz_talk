import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendAcceptService{
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> acceptFriendRequest(String targetUserId) async {
  final currentUserId = auth.currentUser!.uid;
  try {
    DocumentReference currentUserRef = firestore.collection('users').doc(currentUserId);
    DocumentReference targetUserRef = firestore.collection('users').doc(targetUserId);

    await firestore.runTransaction((transaction) async {
      DocumentSnapshot currentUserSnapshot = await transaction.get(currentUserRef);
      DocumentSnapshot targetUserSnapshot = await transaction.get(targetUserRef);

      if (currentUserSnapshot.exists && targetUserSnapshot.exists) {
        Map<String, dynamic> currentUserData = currentUserSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> targetUserData = targetUserSnapshot.data() as Map<String, dynamic>;

        List<String> currentUserFriends = currentUserData['friends'] != null
            ? List<String>.from(currentUserData['friends'])
            : [];
        List<String> targetUserFriends = targetUserData['friends'] != null
            ? List<String>.from(targetUserData['friends'])
            : [];
        List<String> currentUserRequests = currentUserData['friend_requests'] != null
            ? List<String>.from(currentUserData['friend_requests'])
            : [];

        if (currentUserRequests.contains(targetUserId)) {
          currentUserRequests.remove(targetUserId);
          currentUserFriends.add(targetUserId);
          targetUserFriends.add(currentUserId);

          transaction.update(currentUserRef, {
            'friend_requests': currentUserRequests,
            'friends': currentUserFriends,
          });
          transaction.update(targetUserRef, {
            'friends': targetUserFriends,
          });
        }
      }
    });
    return true;
  } catch (e) {
    print('Error accepting friend request: $e');
    return false;
  }
}
}