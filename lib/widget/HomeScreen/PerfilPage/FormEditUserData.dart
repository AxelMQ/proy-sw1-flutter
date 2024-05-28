// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proy_sw1/widget/ButtonWidget.dart';
import 'package:proy_sw1/widget/RegisterUserDataScreen/FechaSelectWidget.dart';
import 'package:proy_sw1/widget/RegisterUserDataScreen/MenuItemWidget.dart';

import '../../../data/user_data.dart';
import '../../FormTextFieldWidget.dart';

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

  Future<void> _updateData() async {
    try {
      FormData formData = FormData.fromMap({
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'telefono': telefonoController.text,
        'email': emailController.text,
        'sexo': sexoController.text,
        'fecha_nac': fechaNacController.text,
        'user_id': widget.userData!.userId,
      });
      print('DATOS ENVIADOS---> ${formData.fields}');
    } catch (e) {}
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
