
import 'package:flutter/material.dart';
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
                      print('LOGIN SUCCESS!!!');
                      print(usernameController.text);
                      print(passwordController.text);
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
