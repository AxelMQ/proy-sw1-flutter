import 'package:proy_sw1/data/user.dart';

class Friendship {
  final int id;
  final User user;
  final User? friend;
  final String estado;

  Friendship({
    required this.id,
    required this.user,
    this.friend,
    required this.estado,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json['id'],
      user: User.fromJson(json['user']),
      friend: json['friend'] != null ? User.fromJson(json['friend']) : null,
      estado: json['estado'],
    );
  }
}
