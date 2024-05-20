import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextPasswordWidget extends StatefulWidget {
  final String text;
  final TextEditingController? controllerForm;
  final TextInputType? keyword;
  final String? Function(String?)? onValidator;
  final bool? convertToUpperCase;

  const FormTextPasswordWidget({
    super.key,
    required this.text,
    this.controllerForm,
    this.keyword,
    this.onValidator,
    this.convertToUpperCase = false,
  });

  @override
  State<FormTextPasswordWidget> createState() => _FormTextPasswordWidgetState();
}

class _FormTextPasswordWidgetState extends State<FormTextPasswordWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllerForm,
      keyboardType: widget.keyword,
      validator: widget.onValidator,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.text,
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
          borderRadius: BorderRadius.circular(13.0),
        ),
        suffixIcon: IconButton(
            icon: Icon(_obscureText
                ? Icons.visibility
                : Icons.visibility_off_outlined),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            }),
      ),
    );
  }
}
