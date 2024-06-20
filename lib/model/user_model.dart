class UserModel {
  String? userName;
  String? email;
  String? userId;
  List<String>? friendRequests;
  List<String>? friends; 

  UserModel({
    this.email,
    this.userId,
    this.userName,
    this.friendRequests,
    this.friends,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['name'],
      email: json['email'],
      userId: json['userid'],
      friendRequests: json['friend_requests'] != null
          ? List<String>.from(json['friend_requests'])
          : [],
      friends: json['friends'] != null ? List<String>.from(json['friends']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': userName,
      'email': email,
      'userid': userId,
      'friend_requests': friendRequests,
      'friends': friends,
    };
  }
}
