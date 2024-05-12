import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home' : (context) => const HomeScreen(),
      },
      theme: ThemeData(useMaterial3: true),
    );
  }
}