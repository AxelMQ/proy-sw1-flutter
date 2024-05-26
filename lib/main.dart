import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import 'package:proy_sw1/service/storage_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto App',
      debugShowCheckedModeBanner: false,
      // initialRoute: '/login',
      // routes: {
      //   // '/home' : (context) => const HomeScreen(),
      //   '/login': (context) => const LoginScreen(),
      // },
      home: const AuthenticationWrapper(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

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
