import 'package:proy_sw1/data/user_data.dart';

class User {
  final int id;
  final String username;
  final UserData? userData;

  User({required this.id, required this.username, this.userData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      userData: json['user_data'] != null
          ? UserData.fromJson(json['user_data'])
          : null,
    );
  }
}
