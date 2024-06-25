// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../ButtonIconWidget.dart';
import 'AddIngredienteWidget.dart';
import 'IngredientesListWidget.dart';

class GenerateRecetaBodyWidget extends StatefulWidget {
  const GenerateRecetaBodyWidget({
    super.key,
  });

  @override
  State<GenerateRecetaBodyWidget> createState() =>
      _GenerateRecetaBodyWidgetState();
}

class _GenerateRecetaBodyWidgetState extends State<GenerateRecetaBodyWidget> {
  final TextEditingController _ingredientesController = TextEditingController();
  final List<String> _ingredientes = [];

  void _addIngredientes(String ingrediente) {
    if (ingrediente.isNotEmpty) {
      setState(() {
        _ingredientes.add(ingrediente);
      });
    }
  }

  void _removeIngrediente(int index) {
    setState(() {
      _ingredientes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Text(
        //   'Generate Receta',
        //   style: TextStyle(fontSize: 20),
        // ),
        const SizedBox(height: 10),
        AddIngredienteWidget(
          ingredientesController: _ingredientesController,
          onAdd: _addIngredientes,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Ingredientes Agregados:',
          style: GoogleFonts.titilliumWeb(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        IngredientesListWidget(
          ingredientes: _ingredientes,
          onRemove: _removeIngrediente,
        ),
        const SizedBox(height: 10),
        ButtonIconWidget(
          text: 'Generar Receta',
          onTap: () {
            print(_ingredientes.toString());
            print('sk-my-service-account1-7uZgYvvdDvYfmz8Epe2DT3BlbkFJUfmOCCQi3ttexL2Lpzb7');
          },
        )
      ],
    );
  }
}
