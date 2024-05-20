import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/screen/RegisterUserScreen.dart';

class RegisterRowWidget extends StatelessWidget {
  const RegisterRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes una cuenta?',
          style: GoogleFonts.chakraPetch(
              fontSize: 15, fontWeight: FontWeight.w300),
        ),
        TextButton(
          child: Text(
            'Registrarme',
            style: GoogleFonts.chakraPetch(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.orange),
          ),
          onPressed: () {
            print('GO --> REGISTER');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterUserScreen()),
            );
          },
        )
      ],
    );
  }
}
