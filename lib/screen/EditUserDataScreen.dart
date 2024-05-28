import 'package:flutter/material.dart';
import '../data/user_data.dart';
import '../widget/HomeScreen/PerfilPage/FormEditUserData.dart';

class EditUserDataScreen extends StatelessWidget {
  final UserData? userData;

  const EditUserDataScreen({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Editar Informacion',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          elevation: 5,
          backgroundColor: Colors.amber[800]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
              const Text('Editar Informacion'),
              FormEditUserDataWidget(userData: userData,),
            ],
          ),
        ),
      ),
    );
  }
}
