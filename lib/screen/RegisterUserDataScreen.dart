// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:proy_sw1/widget/TitleTextWidget.dart';
import '../widget/RegisterUserDataScreen/FormRegisterDataUserWidget.dart';
import '../widget/RegisterUserScreen/AnimationWidget.dart';

class RegisterUserDataScreen extends StatelessWidget {
  final int userId;
  final String username;

  const RegisterUserDataScreen(
      {super.key, required this.userId, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Datos Personales',
            style: GoogleFonts.chakraPetch(fontWeight: FontWeight.w400)),
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.deepOrange,
        shadowColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Bienvenido @$username. \nCompleta los siguientes datos.',
                style: GoogleFonts.chakraPetch(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const Divider(),
              const SizedBox(height: 10),
              FormRegisterDataUserWidget(userId: userId),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
