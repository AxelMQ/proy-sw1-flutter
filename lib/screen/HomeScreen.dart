import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String token;
  final String username;

  const HomeScreen({super.key, required this.token, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Proyecto App'),
          elevation: 5,
          backgroundColor: Colors.black38),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 150),
            Text('Username: $username' ),
            Text('Token:  $token'),
          ],
        ),
      ),
    );
  }
}
