import 'package:buzztalk/model/message_model.dart';
import 'package:buzztalk/service/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  ChatService chatService = ChatService();
  FirebaseAuth auth = FirebaseAuth.instance;
  ScrollController scrollController = ScrollController();
  List<MessageModel> messages = [];

  void getMessages(String receiverId) {
    final currentUserId= auth.currentUser!.uid;
    List ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    chatService.getMessages(chatRoomId).listen((messageList) {
      messages = messageList;
      notifyListeners();
      scrollDown();
    });
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
}
