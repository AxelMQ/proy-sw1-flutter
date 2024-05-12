import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto App'),
        elevation: 5,
        backgroundColor: Colors.black38,
      ),
      body: const Center(child: Text('Home Screen')),
    );
  }
}
