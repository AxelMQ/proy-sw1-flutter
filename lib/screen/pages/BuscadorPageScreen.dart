// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../widget/HomeScreen/BuscadorPage/FormSearchWidget.dart';

class BuscadorPageScreen extends StatelessWidget {
  final String? token;
  final String? username;

  const BuscadorPageScreen({super.key, this.token, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador Page'),
        automaticallyImplyLeading: false,
      ),
      body: const FormSearchWidget(),
    );
  }
}
