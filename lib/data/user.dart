import 'package:proy_sw1/data/user_data.dart';

class User {
  final int id;
  final String username;
  final UserData? userData;
  final String? relationStatus;
  final int? friendsCount;

  User({
    required this.id,
    required this.username,
    this.userData,
    required this.relationStatus,
    this.friendsCount,
  });

  User copyWith({
    int? id,
    String? username,
    UserData? userData,
    String? relationStatus,
    int? friendsCount
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      userData: userData ?? this.userData,
      relationStatus: relationStatus ?? this.relationStatus,
      friendsCount: friendsCount ?? this.friendsCount
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      userData: json['user_data'] != null
          ? UserData.fromJson(json['user_data'])
          : null,
      relationStatus: json['relationship_status'],
      friendsCount : json['friends_count']
    );
  }
}
