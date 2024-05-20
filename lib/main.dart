import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import 'package:proy_sw1/screen/RegisterUserDataScreen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home' : (context) => const HomeScreen(),
        '/login' : (context) => const LoginScreen(),
        '/registerData' :(context) => const RegisterUserDataScreen(),
      },
      theme: ThemeData(useMaterial3: true),
    );
  }
}