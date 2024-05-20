// ignore_for_file: unnecessary_null_comparison, file_names
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../ButtonWidget.dart';
import '../FormTextFieldWidget.dart';
import 'FechaSelectWidget.dart';
import 'ImageSelectWidget.dart';
import 'MenuItemWidget.dart';

class FormRegisterDataUserWidget extends StatefulWidget {
  const FormRegisterDataUserWidget({
    super.key,
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
                      print('GUARDAR DATOS PERSONALES');
                      print(nombreController.text);
                      print(apellidoController.text);
                      print(telefonoController.text);
                      print(correoController.text);
                      print(sexoController.text);
                      print(fechaNacController.text);
                      print(imageController.text);
                      if (_imageNotifier.value != null) {
                        print('Imagen: ${_imageNotifier.value!.path}');
                      } else {
                        print('No se ha seleccionado una imagen.');
                      }
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
