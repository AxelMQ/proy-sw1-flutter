import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'AuthenticationWrapper.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Current directory: ${Directory.current.path}');

  // Ruta absoluta al archivo .env
  const envPath = '.env';
  final envFile = File(envPath);
  if (await envFile.exists()) {
    print('.env file exists at: ${envFile.absolute.path}');
    print('File contents:');
    print(await envFile.readAsString());
  } else {
    print('.env file does not exist at: ${envFile.absolute.path}');
  }

  try {
    // Carga las variables de entorno desde el archivo .env
    dotenv.testLoad(fileInput: await envFile.readAsString());
    print('Loaded .env file successfully using testLoad');
    
    // Accede a las variables de entorno
    String apiKey = dotenv.env['API_KEY'] ?? '';
    String apiLaravel = dotenv.env['API_LARAVEL'] ?? '';

    print('API_KEY: $apiKey');
    print('API_LARAVEL: $apiLaravel');
  } catch (e) {
    print('Error loading .env file: $e');
    print('Exception details: ${e.toString()}');
  }

  // Inicia la aplicación Flutter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto App',
      debugShowCheckedModeBanner: false,
      home: const AuthenticationWrapper(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
