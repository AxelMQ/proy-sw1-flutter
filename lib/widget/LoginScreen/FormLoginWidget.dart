// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';
import 'package:proy_sw1/service/storage_service.dart';
import '../ButtonWidget.dart';
import '../FormTextFieldWidget.dart';
import '../FormTextPasswordWidget.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({
    super.key,
  });

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  Future<void> _login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        });
    try {
      final response = await _dio.post(
        'http://192.168.100.2:8000/api/login',
        data: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        print('RESPUESTA DEL SERVIDOR: ${response.data}');
        usernameController.clear();
        passwordController.clear();

        final token = response.data['token'];
        final username = response.data['username'];
        await StorageService.saveToken(token);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      token: token,
                      username: username,
                    )));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            'Inicio Exitoso.',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ));
      } else if (response.statusCode == 404) {
        print('ERROR: Codigo de estado -> ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orange,
            content: Text('Usuario no Encontrado. Verifique nuevamente.'),
          ),
        );
      } else if (response.statusCode == 401) {
        print('ERROR: Codigo de estado -> ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Contraseña Incorrecta, intentalo nuevamente.'),
          ),
        );
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error desconocido, intentalo nuevamente.'),
          ),
        );
      }
    } catch (e) {
      print('ERROR: $e');

      Navigator.of(context).pop();
      // Mostrar mensaje de error genérico
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Error al conectar con el servidor, intentalo nuevamente.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextFieldWidget(
            text: 'Usuario',
            controllerForm: usernameController,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido.' : null,
          ),
          const SizedBox(height: 20),
          FormTextPasswordWidget(
            text: 'Contraseña',
            controllerForm: passwordController,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido.' : null,
          ),
          const SizedBox(height: 70),
          Center(
            child: SizedBox(
                height: 45,
                width: 300,
                child: ButtonWidget(
                  text: 'Ingresar',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
