// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../ButtonIconWidget.dart';
import 'AddIngredienteWidget.dart';
import 'IngredientesListWidget.dart';

class GenerateRecetaBodyWidget extends StatefulWidget {
  const GenerateRecetaBodyWidget({super.key});

  @override
  State<GenerateRecetaBodyWidget> createState() =>
      _GenerateRecetaBodyWidgetState();
}

class _GenerateRecetaBodyWidgetState extends State<GenerateRecetaBodyWidget> {
  final TextEditingController _ingredientesController = TextEditingController();
  final List<String> _ingredientes = [];
  final Dio _dio = Dio();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEnv();
  }

  Future<void> _loadEnv() async {
    // await dotenv.load();
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    print('---> Loaded API key: $apiKey');
  }

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

  Future<void> _generateReceta() async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      print('-- API key is missing');
      return;
    }

    final prompt =
        'Genera una receta de cocina a partir de estos ingredientes: ${_ingredientes.join(', ')}';
    const url = 'https://api.openai.com/v1/completions';

    int retries = 5; // Número de reintentos permitidos
    int retryDelay = 2; // Tiempo de espera inicial entre reintentos en segundos

    setState(() {
      _isLoading = true;
    });
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Generando receta...'),
              ],
            ),
          );
        },
      );

      for (int attempt = 0; attempt < retries; attempt++) {
        final response = await _dio.post(
          url,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $apiKey',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                'role': 'user',
                'content': prompt,
              }
            ],
            'max_tokens': 150,
            'temperature': 0.7,
          },
        );
        print(response.statusCode);

        if (response.statusCode == 200) {
          final data = response.data;
          final receta = data['choices'][0]['message']['content'];
          print('Generated Recipe: $receta');
          Navigator.of(context).pop(); // Cerrar el diálogo de carga
          _showRecetaDialog(receta);
          return;
        } else if (response.statusCode == 429) {
          print('Rate limit exceeded. Retrying in $retryDelay seconds...');
          await Future.delayed(Duration(seconds: retryDelay));
          retryDelay *= 2; // Incrementar el tiempo de espera exponencialmente
        } else {
          print('Failed to generate recipe: ${response.statusCode}');
          print('Response body: ${response.data}');
          Navigator.of(context).pop(); // Cerrar el diálogo de carga
          _showErrorDialog(); // Mostrar un diálogo de error
          return;
        }
      }
      // Si llegamos aquí, se agotaron los intentos
      Navigator.of(context).pop(); // Cerrar el diálogo de carga
      _showErrorDialog();
    } catch (e) {
      print('Error generating recipe: $e');
      Navigator.of(context).pop(); // Cerrar el diálogo de carga
      _showErrorDialog(); // Mostrar un diálogo de error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showRecetaDialog(String receta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Receta Generada'),
          content: Text(receta),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Hubo un error al generar la receta.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        AddIngredienteWidget(
          ingredientesController: _ingredientesController,
          onAdd: _addIngredientes,
        ),
        const SizedBox(height: 20),
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
            _generateReceta();
          },
        )
      ],
    );
  }
}
