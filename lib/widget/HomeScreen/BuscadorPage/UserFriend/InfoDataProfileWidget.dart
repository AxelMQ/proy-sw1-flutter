// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDataProfileWidget extends StatelessWidget {
  const InfoDataProfileWidget({
    super.key,
    required this.text,
    this.icon,
  });

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(width: 5),
        Text(text,
            style: GoogleFonts.titilliumWeb(
                fontSize: 15, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
