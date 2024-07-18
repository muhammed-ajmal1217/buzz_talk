import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String? id;
  final String? userId;
  final String? mediaUrl; 
  final String? textContent;
  final DateTime? timestamp;
  final List<String>? viewers;
  final String?storyType;
  bool viewed; 

  Story({
    this.id,
    this.userId,
    this.mediaUrl,
    this.textContent,
    this.timestamp,
    this.viewers,
    this.viewed = false, 
    this.storyType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'mediaUrl': mediaUrl,
      'textContent': textContent,
      'timestamp': timestamp,
      'viewers': viewers,
      'viewed': viewed, 
      'storyType':storyType
    };
  }

  static Story fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      userId: json['userId'],
      mediaUrl: json['mediaUrl'] as String?,
      textContent: json['textContent'],
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
      viewers: List<String>.from(json['viewers'] ?? []),
      viewed: json['viewed'] ?? false,
      storyType: json['storyType']
    );
  }
}
