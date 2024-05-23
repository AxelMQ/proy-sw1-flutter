// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/widget/TitleTextWidget.dart';
import '../widget/RegisterUserDataScreen/FormRegisterDataUserWidget.dart';

class RegisterUserDataScreen extends StatelessWidget {
  final int userId;
  final String username;

  const RegisterUserDataScreen(
      {super.key, required this.userId, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextWidget(text: 'Datos Personales'),
               Text('User ID: $userId\nUsername: $username'),
              Text(
                '@$username, Complete los siguientes datos.',
                style: GoogleFonts.chakraPetch(
                    fontSize: 18, fontWeight: FontWeight.w300),
              ),
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
