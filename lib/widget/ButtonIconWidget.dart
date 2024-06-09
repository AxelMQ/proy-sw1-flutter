// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget({
    super.key,
    this.onTap,
    this.buttonColor,
    this.textColor, 
    this.icon, 
    this.iconColor, this.text,
  });

  final Function()? onTap;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
           MaterialStatePropertyAll(buttonColor ?? const Color.fromARGB(255, 47, 136, 209)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      icon: Icon(
        icon ?? Icons.send_sharp,
        color: iconColor ??Colors.white,
        size: 15,
      ),
      label: Text(
        text ?? 'Button',
        style: GoogleFonts.titilliumWeb(
          textStyle: TextStyle(
            fontSize: 15,
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
