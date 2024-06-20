import 'package:buzztalk/model/message_model.dart';
import 'package:buzztalk/service/auth_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier{
  AuthenticationService authService = AuthenticationService();
    ScrollController scrollController = ScrollController();
    List<MessageModel> messages = [];
      List<MessageModel> getMessages(String currentuserid,String recieverId) {
    List ids = [currentuserid, recieverId];
    ids.sort();
    String chatroomid = ids.join("_");
    authService.firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots()
        .listen((message) {
      messages =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      notifyListeners();
      scrollDown();
    });
    return messages;
  }
    void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
}