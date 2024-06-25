
import 'package:flutter/material.dart';
import '../../../screen/pages/GenerateRecetas/GenerateReceta.dart';

class ButtonFloatingGenerateWidget extends StatelessWidget {
  const ButtonFloatingGenerateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('CREAR RECETA');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (constext) => const GenerateReceta(),
          ),
        );
      },
      tooltip: 'Generar Receta',
      backgroundColor: const Color.fromARGB(255, 245, 154, 79),
      child: const Icon(
        Icons.note_alt_rounded,
        color: Colors.white70,
      ),
    );
  }
}
