// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/pages/UserFriend/SolicitudesScreen.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              print('SOLICITUD ....');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SolicitudesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.people_sharp),
          )
        ],
      ),
      body: const FormSearchWidget(),
    );
  }
}
