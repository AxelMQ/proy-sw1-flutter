import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemWidget extends StatefulWidget {
  final TextEditingController sexoController;
  final String? Function(String?)? onValidator;

  const MenuItemWidget({
    required this.sexoController,
    super.key, 
    this.onValidator,
  });

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Sexo',
        labelStyle: GoogleFonts.dosis(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
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
      ),
      items: ['Masculino', 'Femenino', 'Otro'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: GoogleFonts.dosis(fontWeight: FontWeight.w600)),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget.sexoController.text = value ?? ''; // Actualizar el valor del controlador
        });
      },
      validator: widget.onValidator,
    );
  }
}
