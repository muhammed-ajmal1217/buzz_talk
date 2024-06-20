import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? content;
  String? senderId;
  String? recieverId;

  MessageModel({
    this.content,
    this.recieverId,
    this.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json["content"],
      recieverId: json["recieverId"],
      senderId: json["senderId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "recieverId": recieverId,
      "senderId": senderId,
    };
  }
}
