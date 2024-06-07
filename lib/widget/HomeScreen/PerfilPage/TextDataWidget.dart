
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextDataWidget extends StatelessWidget {
  final String title;
  final String textData;
  const TextDataWidget({
    super.key,
    required this.title,
    required this.textData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.chakraPetch(
              fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          textData,
          style: GoogleFonts.chakraPetch(
              fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
