import 'package:buzztalk/model/story_model.dart';

class UserModel {
  String? userName;
  String? email;
  String? userId;
  String? profilePic;
  int? phoneNumber; 
  String? about;
  DateTime? dob;
  List<String>? friendRequests;
  List<String>? friends;
  List<Story>? stories; 

  UserModel({
    this.userName,
    this.email,
    this.userId,
    this.profilePic,
    this.phoneNumber,
    this.about,
    this.dob,
    this.friendRequests,
    this.friends,
    this.stories, 
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['name'],
      email: json['email'],
      userId: json['userid'],
      profilePic: json['profile_pic'],
      phoneNumber: json['phone_number'] is int ? json['phone_number'] : int.tryParse(json['phone_number'] ?? ''),
      about: json['about'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      friendRequests: json['friend_requests'] != null
          ? List<String>.from(json['friend_requests'])
          : [],
      friends: json['friends'] != null ? List<String>.from(json['friends']) : [],
      stories: json['stories'] != null 
          ? List<Story>.from(json['stories'].map((x) => Story.fromJson(x))) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': userName,
      'email': email,
      'userid': userId,
      'profile_pic': profilePic,
      'phone_number': phoneNumber,
      'about': about,
      'dob': dob?.toIso8601String(),
      'friend_requests': friendRequests,
      'friends': friends,
      'stories': stories?.map((story) => story.toJson()).toList(), 
    };
  }
}
