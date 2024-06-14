// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../data/user.dart';
import '../../../widget/HomeScreen/BuscadorPage/UserFriend/ProfileUserFriendWidget.dart';

class ProfileUserScreen extends StatelessWidget {
  final User user;
  final Function() onStatusChanged;

  const ProfileUserScreen({
    super.key,
    required this.user, 
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final userData = user.userData;

    return Scaffold(
      appBar: AppBar(
        title: Text('@${user.username}'),
      ),
      body: ProfileUserFriendWidget(userData: userData, user: user, onStatusChanged: onStatusChanged,),
    );
  }
}
