// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import '../ButtonWidget.dart';
import '../FormTextFieldWidget.dart';
import '../FormTextPasswordWidget.dart';

class FormRegisterUserWidget extends StatefulWidget {
  const FormRegisterUserWidget({
    super.key,
  });

  @override
  State<FormRegisterUserWidget> createState() => _FormRegisterUserWidgetState();
}

class _FormRegisterUserWidgetState extends State<FormRegisterUserWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Dio _dio = Dio();

  Future<void> _registerUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        );
      },
    );

    try {
      final response = await _dio.post(
        'http://192.168.100.2:8000/api/user-register',
        data: {
          'username': usernameController.text,
          'password': passwordController.text,
          'password_confirmation': confirmController.text
        },
      );
      print('RESPUESTA DEL SERVIDOR: ${response.data}');
      Navigator.of(context).pop();
      _showConfirmationDialog(
          'Registro Exitoso', 'Usuario registrado exitosamente.');
    } catch (e) {
      Navigator.of(context).pop();
      // ignore: deprecated_member_use
      if (e is DioError) {
        if (e.response != null && e.response!.data != null) {
          final errors = e.response!.data['errors'];
          String errorMessages = '';
          errors.forEach((key, value) {
            errorMessages += '${value[0]}\n';
          });
          _showConfirmationDialog('Error', errorMessages);
        } else {
          _showConfirmationDialog('Error',
              'No se pudo registrar el usuario. Verifique los datos proporcionados.');
        }
      } else {
        _showConfirmationDialog('Error',
            'No se pudo registrar el usuario. Verifique los datos proporcionados.');
      }
    }
  }

  void _showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.titilliumWeb(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  title == 'Error' ? 'assets/error.json' : 'assets/good.json',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title == 'Error') {
                  Navigator.of(context).pop();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                  usernameController.clear();
                  passwordController.clear();
                  confirmController.clear();
                }
              },
              child: Text(
                'OK',
                style: GoogleFonts.titilliumWeb(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
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
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 15),
          FormTextPasswordWidget(
            text: 'Contraseña',
            controllerForm: passwordController,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 15),
          FormTextPasswordWidget(
            text: 'Confirmar Contraseña',
            controllerForm: confirmController,
            onValidator: (p0) {
              if (p0!.isEmpty) {
                return 'Campo Requerido';
              } else if (p0 != passwordController.text) {
                return 'Contraseñas no coinciden';
              }
              return null;
            },
          ),
          const SizedBox(height: 45),
          Center(
            child: SizedBox(
              height: 45,
              width: 300,
              child: ButtonWidget(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _registerUser();
                    }
                  },
                  text: 'Registrar'),
            ),
          ),
        ],
      ),
    );
  }
}
