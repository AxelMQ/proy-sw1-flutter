// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:proy_sw1/screen/LoginScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../ButtonWidget.dart';
import '../FormTextFieldWidget.dart';
import 'FechaSelectWidget.dart';
import 'ImageSelectWidget.dart';
import 'MenuItemWidget.dart';

class FormRegisterDataUserWidget extends StatefulWidget {
  final int userId;
  const FormRegisterDataUserWidget({
    super.key,
    required this.userId,
  });

  @override
  State<FormRegisterDataUserWidget> createState() =>
      _FormRegisterDataUserWidgetState();
}

class _FormRegisterDataUserWidgetState
    extends State<FormRegisterDataUserWidget> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();
  final TextEditingController fechaNacController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);

  DateTime? _selectedDate;
  final Dio _dio = Dio();
  Future<void> _registerData() async {
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
      FormData formData = FormData.fromMap({
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'telefono': telefonoController.text,
        'email': correoController.text,
        'sexo': sexoController.text,
        'fecha_nac': fechaNacController.text,
        'ruta_foto': _imageNotifier.value != null
            ? await MultipartFile.fromFile(_imageNotifier.value!.path)
            : null,
        'user_id': widget.userId,
      });
      print('Datos enviados: $formData');
      final apiLaravel = dotenv.env['API_LARAVEL'];
      final response = await _dio.post(
        '$apiLaravel/userdata-register',
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      Navigator.of(context).pop();
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('RESPUESTA DEL SERVIDOR: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            'Registro Completado.',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ));
        _showConfirmationDialog(
            'Registro Exitoso', 'Datos Personales registrados correctamente.');
      } else {
        print('Error: ${response.data}');
        final errors = response.data['errors'];
        String errorMessages = '';
        errors.forEach((key, value) {
          errorMessages += '${value[0]}\n';
        });

        _showConfirmationDialog(
            'Error', '${response.data['message']} : \n $errorMessages');
      }
    } catch (e) {
      print('ERROR: $e');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Error al conectar con el servidor, intentalo nuevamente.'),
      ));
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
                }
              },
              child: title == 'Error'
                  ? Text(
                      'Reintentar',
                      style: GoogleFonts.titilliumWeb(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Iniciar Sesion',
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
          const SizedBox(height: 10),
          ImageSelectWidget(imageNotifier: _imageNotifier),
          const SizedBox(height: 15),
          FormTextFieldWidget(
            text: 'Nombre',
            controllerForm: nombreController,
            textCapitalization: TextCapitalization.words,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 10),
          FormTextFieldWidget(
            text: 'Apellido',
            controllerForm: apellidoController,
            textCapitalization: TextCapitalization.words,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido.' : null,
          ),
          const SizedBox(height: 10),
          FormTextFieldWidget(
            text: 'Telefono',
            keyword: TextInputType.phone,
            controllerForm: telefonoController,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 10),
          FormTextFieldWidget(
            text: 'Correo Electronico',
            keyword: TextInputType.emailAddress,
            controllerForm: correoController,
            onValidator: (p0) {
              if (p0!.isEmpty) {
                return 'Campo Requerdio.';
              }
              if (!EmailValidator.validate(p0)) {
                return 'Correo Electronico Invalido';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          MenuItemWidget(
            sexoController: sexoController,
            onValidator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Campo Requerido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          FechaSelectWidget(
            selectedDate: _selectedDate,
            fechaNacController: fechaNacController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
                height: 40,
                width: 300,
                child: ButtonWidget(
                  text: 'Guardar Datos',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // if (_imageNotifier.value != null) {
                      //   print('Imagen: ${_imageNotifier.value!.path}');
                      // } else {
                      //   print('No se ha seleccionado una imagen.');
                      // }
                      _registerData();
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
