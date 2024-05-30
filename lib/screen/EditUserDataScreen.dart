import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/data/user.dart';
import 'package:proy_sw1/widget/RegisterUserScreen/AnimationWidget.dart';
import 'package:proy_sw1/widget/TitleTextWidget.dart';
import '../data/user_data.dart';
import '../widget/HomeScreen/PerfilPage/FormEditUserData.dart';

class EditUserDataScreen extends StatelessWidget {
  final UserData? userData;
  final User? user;

  const EditUserDataScreen({super.key, this.userData, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '@${user!.username}',
            style: GoogleFonts.titilliumWeb(fontWeight: FontWeight.w400),
          ),
          elevation: 5,
          backgroundColor: Colors.amber[800]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: AnimationWidget(path: 'assets/user_animation.json'),
              ),
              const TitleTextWidget(text: 'EDITAR INFORMACION'),
              const Divider(height: 30),
              FormEditUserDataWidget(
                userData: userData,
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
