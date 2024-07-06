import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String? id;
  final String? userId;
  final String? imageUrl;
  final String? videoUrl;
  final String? textContent;
  final DateTime? timestamp; 
  final List<String>? viewers;

  Story({
    this.id,
    this.userId,
    this.imageUrl,
    this.videoUrl,
    this.textContent,
    this.timestamp,
    this.viewers,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'mediaUrl': imageUrl,
      'videoUrl': videoUrl,
      'textContent': textContent,
      'timestamp': timestamp, 
      'viewers': viewers,
    };
  }

  static Story fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      userId: json['userId'],
      imageUrl: json['mediaUrl'] as String?,
      videoUrl: json['videoUrl'],
      textContent: json['textContent'],
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(), 
      viewers: List<String>.from(json['viewers'] ?? []),
    );
  }
}
