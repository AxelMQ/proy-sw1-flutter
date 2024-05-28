import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              backgroundColor ?? Colors.orange),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(text,
            style: GoogleFonts.dosis(
                textStyle: TextStyle(
              fontSize: 20,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
            ))));
  }
}
