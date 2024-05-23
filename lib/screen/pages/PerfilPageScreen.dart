import 'package:flutter/material.dart';

class PerfilPageScreen extends StatelessWidget {
  final String token;
  final String username;
  const PerfilPageScreen(
      {super.key, required this.token, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Page'),
      ),
      body: Center(child: Text('USERNAME: $username')),
    );
  }
}
