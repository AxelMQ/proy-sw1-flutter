// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldSearchWidget extends StatelessWidget {
  final Function()? onTap;

  const TextFieldSearchWidget({
    super.key,
    required TextEditingController searchController,
    this.onTap,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: 'Buscar',
        labelStyle: GoogleFonts.dosis(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 238, 163, 51),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: const Icon(Icons.person_search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onTap,
              )
            : const Icon(Icons.search_sharp),
      ),
    );
  }
}
