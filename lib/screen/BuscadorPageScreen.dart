import 'package:flutter/material.dart';

class BuscadorPageScreen extends StatelessWidget {
  final String token;
  final String username;

  const BuscadorPageScreen(
      {super.key, required this.token, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador Page'),
      ),
      body: const Text('Pagina de Buscador'),
    );
  }
}
