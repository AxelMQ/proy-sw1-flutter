// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../widget/HomeScreen/HomePage/GenerateReceta/GenerateRecetaBody.dart';

class GenerateReceta extends StatelessWidget {
  const GenerateReceta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Recetas'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(5.0),
        child: GenerateRecetaBodyWidget(),
      ),
    );
  }
}
