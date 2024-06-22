// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../data/user.dart';
import '../../data/user_data.dart';
import '../../widget/HomeScreen/PerfilPage/FloatingButtonWidget.dart';
import '../../widget/HomeScreen/PerfilPage/PerfilUserWidget.dart';

class PerfilPageScreen extends StatelessWidget {
  final User? user;
  final UserData? userData;
  final Function() onStatusChanged;

  const PerfilPageScreen({
    super.key,
    this.user,
    this.userData,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text('Perfil'),
          ],
        ),
      ),
      body: PerfilUserWidget(
        userData: userData,
        user: user,
        onStatusChanged: onStatusChanged,
      ),
      floatingActionButton:
          FlotatingButtonWidget(onStatusChanged: onStatusChanged),
    );
  }
}
