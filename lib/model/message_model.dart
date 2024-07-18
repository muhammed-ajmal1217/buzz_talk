import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? content;
  String? senderId;
  String? recieverId;
  Timestamp? time;

  MessageModel({
    this.content,
    this.recieverId,
    this.senderId,
    this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json["content"],
      recieverId: json["recieverId"],
      senderId: json["senderId"],
      time: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "recieverId": recieverId,
      "senderId": senderId,
      "timestamp":time,
    };
  }
}
