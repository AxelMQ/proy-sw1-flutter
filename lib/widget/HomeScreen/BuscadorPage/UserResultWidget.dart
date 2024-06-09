// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/pages/UserFriend/ProfileUserScreen.dart';

class UserResultWidget extends StatelessWidget {
  const UserResultWidget({
    super.key,
    required this.userData,
    required this.user,
  });

  final userData;
  final user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('--> TAP TAP');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileUserScreen(user: user),
          ),
        );
      },
      child: ListTile(
        leading: userData?.rutaFoto != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://192.168.100.2:8000/storage/${userData!.rutaFoto}'),
              )
            : CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text(
                  user.username[0].toUpperCase(),
                ),
              ),
        title: Text(user.username),
        subtitle: userData != null ? Text(userData.nombre) : null,
        trailing: IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: () {
            // sendFriendRequest(user.id);
            print('SELECT USER --> ${user.id}');
          },
        ),
      ),
    );
  }
}
