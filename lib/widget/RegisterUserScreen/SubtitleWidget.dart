
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Ya tienes una cuenta?',
          style: GoogleFonts.chakraPetch(
              fontSize: 18, fontWeight: FontWeight.w300),
        ),
        TextButton(
          child: Text(
            'Iniciar Sesion',
            style: GoogleFonts.chakraPetch(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.orange),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
