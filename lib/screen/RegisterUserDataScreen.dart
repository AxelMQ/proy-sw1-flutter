// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/widget/TitleTextWidget.dart';
import '../widget/RegisterUserDataScreen/FormRegisterDataUserWidget.dart';

class RegisterUserDataScreen extends StatelessWidget {
  const RegisterUserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextWidget(text: 'Datos Personales'),
              Text(
                'Completa los siguientes datos.',
                style: GoogleFonts.chakraPetch(
                    fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 10),
              const FormRegisterDataUserWidget(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
