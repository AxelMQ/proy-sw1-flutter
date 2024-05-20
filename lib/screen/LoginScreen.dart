// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import '../widget/LoginScreen/FormLoginWidget.dart';
import '../widget/LoginScreen/ImageCurvedWidget.dart';
import '../widget/LoginScreen/RegisterRowWidget.dart';
import '../widget/TitleTextWidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
      ),
      const Positioned(
        child: ImageCurvedWidget(),
      ),
      Positioned.fill(
        top: MediaQuery.of(context).size.height * 0.35,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TitleTextWidget(
                  text: 'Bienvenido',
                ),
                SizedBox(height: 40),
                FormLoginWidget(),
                RegisterRowWidget()
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
