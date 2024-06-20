import 'package:buzztalk/model/message_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthenticationService authService = AuthenticationService();
  Reference storage = FirebaseStorage.instance.ref();
  sendMessage(String recieverId, String message) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    MessageModel newmessage = MessageModel(
      content: message,
      recieverId: recieverId,
      senderId: currentUserId,
    );

    List ids = [currentUserId, recieverId];
    ids.sort();
    String chatroomid = ids.join("_");
    await firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .add(newmessage.toJson());
  }
}
