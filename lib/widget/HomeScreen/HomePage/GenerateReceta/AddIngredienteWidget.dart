// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../ButtonIconWidget.dart';
import '../../../FormTextFieldWidget.dart';

class AddIngredienteWidget extends StatelessWidget {
  const AddIngredienteWidget({
    super.key,
    required TextEditingController ingredientesController,
    required this.onAdd,
  }) : _ingredientesController = ingredientesController;

  final TextEditingController _ingredientesController;
  final Function(String) onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 47,
          width: 250,
          child: FormTextFieldWidget(
            text: 'Ingrediente',
            controllerForm: _ingredientesController,
          ),
        ),
        const SizedBox(width: 5),
        ButtonIconWidget(
          text: 'Agregar',
          icon: Icons.add,
          buttonColor: const Color.fromARGB(255, 37, 117, 155),
          onTap: () {
            print('AGREGAR INGREDIENTE');
            // _addIngredientes();
            final ingrediente = _ingredientesController.text;
            _ingredientesController.clear();
            onAdd(ingrediente);
          },
        ),
      ],
    );
  }
}
