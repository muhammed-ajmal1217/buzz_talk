import 'dart:io';

import 'package:buzztalk/model/message_model.dart';
import 'package:buzztalk/service/chat_service.dart';
import 'package:file_picker/file_picker.dart';
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
    void pickDocument(String recieverId) async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      await chatService.uploadPdf(recieverId, fileName, file);
      print('PDF upload Successful');
    }
    
  }
}
