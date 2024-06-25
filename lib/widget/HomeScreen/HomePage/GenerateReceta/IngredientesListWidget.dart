// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientesListWidget extends StatelessWidget {
  final List<String> ingredientes;
  final Function(int) onRemove;

  const IngredientesListWidget({
    super.key,
    required this.ingredientes,
    required this.onRemove,
  }) : _ingredientes = ingredientes;

  final List<String> _ingredientes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _ingredientes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_ingredientes[index]),
            onDismissed: (direction) {
              onRemove(index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Text(
                    _ingredientes[index],
                    style: GoogleFonts.titilliumWeb(fontSize: 15),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
