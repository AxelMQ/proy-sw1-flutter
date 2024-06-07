// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import 'package:proy_sw1/service/storage_service.dart';
import 'package:proy_sw1/widget/ButtonWidget.dart';

class HomePageScreen extends StatelessWidget {
  final String? token;
  final String? username;

  const HomePageScreen(
      {super.key, this.token, this.username});

  Future<void> _logout(BuildContext context) async {
    await StorageService.clearToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    String? _token = await StorageService.getToken();
    print('---> TOKEN: $_token');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('USERNAME: $username'),
          Text('TOKEN: $token'),
          const SizedBox(height: 30),
          ButtonWidget(
            text: 'Cerrar Sesion',
            onTap: () => _logout(context),
          )
        ],
      )),
    );
  }
}
