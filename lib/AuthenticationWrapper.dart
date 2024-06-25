// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import 'package:proy_sw1/service/storage_service.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
