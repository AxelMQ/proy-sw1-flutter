import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  final String token;
  final String username;

  const HomePageScreen(
      {super.key, required this.token, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('USERNAME: $username'),
          Text('TOKEN: $token'),
        ],
      )),
    );
  }
}
