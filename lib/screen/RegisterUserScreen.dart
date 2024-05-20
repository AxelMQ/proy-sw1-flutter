// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../widget/RegisterUserScreen/AnimationWidget.dart';
import '../widget/RegisterUserScreen/FormRegisterUserWidget.dart';
import '../widget/RegisterUserScreen/SubtitleWidget.dart';
import '../widget/TitleTextWidget.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AnimationWidget(path: 'assets/register_Animation.json'),
              SizedBox(height: 20),
              TitleTextWidget(text: 'Crear Cuenta.'),
              SubtitleWidget(),
              SizedBox(height: 35),
              FormRegisterUserWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
