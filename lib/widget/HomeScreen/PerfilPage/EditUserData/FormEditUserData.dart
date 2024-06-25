// ignore_for_file: file_names, unnecessary_null_comparison, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:proy_sw1/screen/HomeScreen.dart';
import 'package:proy_sw1/widget/ButtonWidget.dart';
import 'package:proy_sw1/widget/RegisterUserDataScreen/FechaSelectWidget.dart';
import 'package:proy_sw1/widget/RegisterUserDataScreen/MenuItemWidget.dart';
import '../../../../data/user_data.dart';
import '../../../FormTextFieldWidget.dart';
import '../../../MessageDialogWidget.dart';

class FormEditUserDataWidget extends StatefulWidget {
  final UserData? userData;

  const FormEditUserDataWidget({
    super.key,
    this.userData,
  });

  @override
  State<FormEditUserDataWidget> createState() => _FormEditUserDataWidgetState();
}

class _FormEditUserDataWidgetState extends State<FormEditUserDataWidget> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController telefonoController;
  late TextEditingController emailController;
  late TextEditingController sexoController;
  late TextEditingController fechaNacController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Dio _dio = Dio();

  Future<void> _updateData() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        );
      },
    );
    try {
      final Map<String, dynamic> userData = {
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'telefono': telefonoController.text,
        'email': emailController.text,
        'sexo': sexoController.text,
        'fecha_nac': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(fechaNacController.text)),
      };
      final apiLaravel = dotenv.env['API_LARAVEL'];
      final response = await _dio.put(
        '$apiLaravel/user-data/${widget.userData!.id}',
        data: userData,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      Navigator.of(context).pop();
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('DATOS DEL USUARIO ACTUALIZADOS EXITOSAMENTE');
        _showConfirmationDialog('Datos Actualizados',
            'Datos Personales actualizados correctamente.');
      } else {
        // print('ERROR AL ACTUALIZAR LOS DATOS --> ${response.statusCode}');
        // print('ERROR AL ACTUALIZAR LOS DATOS --> ${response.data}');
        final errors = response.data['errors'];
        String errorMessages = '';
        errors.forEach((key, value) {
          errorMessages += '${value[0]}\n';
        });
        _showConfirmationDialog(
            'Error', '${response.data['message']} : \n $errorMessages');
      }
    } catch (e) {
      print('EXCEPTION AL ACTUALIZAR ---> $e');
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
        if (title == 'Error') {
          return MessageDialogWidget(title: title, message: message);
        } else {
          return MessageDialogWidget(
            title: title,
            message: message,
            onConfirm: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.userData!.nombre);
    apellidoController = TextEditingController(text: widget.userData!.apellido);
    telefonoController =
        TextEditingController(text: widget.userData!.telefono ?? '');
    emailController = TextEditingController(text: widget.userData!.email);
    sexoController = TextEditingController(text: widget.userData!.sexo);
    fechaNacController = TextEditingController(
        text: widget.userData!.fechaNac != null
            ? DateFormat('dd-MM-yyyy').format(widget.userData!.fechaNac)
            : '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextFieldWidget(
            text: 'Nombre',
            controllerForm: nombreController,
            textCapitalization: TextCapitalization.words,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 15),
          FormTextFieldWidget(
            text: 'Apellido',
            controllerForm: apellidoController,
            textCapitalization: TextCapitalization.words,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido.' : null,
          ),
          const SizedBox(height: 15),
          FormTextFieldWidget(
            text: 'Telefono',
            keyword: TextInputType.number,
            controllerForm: telefonoController,
            onValidator: (p0) => p0!.isEmpty ? 'Campo Requerido' : null,
          ),
          const SizedBox(height: 15),
          FormTextFieldWidget(
            text: 'Email',
            controllerForm: emailController,
            keyword: TextInputType.emailAddress,
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
          const SizedBox(height: 15),
          MenuItemWidget(
            sexoController: sexoController,
            initialValue: widget.userData?.sexo,
            onValidator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          FechaSelectWidget(
            fechaNacController: fechaNacController,
            selectedDate: widget.userData?.fechaNac,
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Actualizar Datos',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _updateData();
                print('ID USER->> ${widget.userData!.id}');
              }
            },
          )
        ],
      ),
    );
  }
}
