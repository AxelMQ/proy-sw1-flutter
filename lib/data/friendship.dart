import 'package:proy_sw1/data/user.dart';

class Friendship {
  final int id;
  final User user;
  final String estado;

  Friendship({
    required this.id,
    required this.user,
    required this.estado,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json['id'],
      user: User.fromJson(json['user']),
      estado: json['estado'],
    );
  }
}
