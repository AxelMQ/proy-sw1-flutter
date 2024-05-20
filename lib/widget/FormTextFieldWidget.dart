import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController? controllerForm;
  final TextInputType? keyword;
  final String? Function(String?)? onValidator;
  final bool? convertToUpperCase;
  final TextCapitalization textCapitalization;

  const FormTextFieldWidget({
    super.key,
    required this.text,
    this.controllerForm,
    this.keyword,
    this.onValidator,
    this.convertToUpperCase = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerForm,
      keyboardType: keyword,
      validator: onValidator,
      obscureText: text.toLowerCase().contains('password'),
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: GoogleFonts.dosis(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.orange,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(13.0))),
    );
  }
}
