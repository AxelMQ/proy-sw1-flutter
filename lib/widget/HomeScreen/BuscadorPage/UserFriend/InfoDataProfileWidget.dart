// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDataProfileWidget extends StatelessWidget {
  const InfoDataProfileWidget({
    super.key,
    required this.text,
    this.icon,
    this.iconWidget,
  });

  final String text;
  final IconData? icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 18,
          ),
        if (iconWidget != null)
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: iconWidget,
          ),
        const SizedBox(width: 5),
        Text(text,
            style: GoogleFonts.titilliumWeb(
                fontSize: 15, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
