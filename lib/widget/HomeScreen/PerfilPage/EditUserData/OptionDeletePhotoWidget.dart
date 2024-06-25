// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/user_data.dart';
import '../../../../screen/HomeScreen.dart';
import '../../../MessageDialogWidget.dart';

class OptionDeletePhotoWidget extends StatelessWidget {
  final UserData? userData;
  final Dio _dio = Dio();

  OptionDeletePhotoWidget({
    super.key,
    this.userData,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Eliminar Foto',
              style: GoogleFonts.titilliumWeb(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            content: Text(
              'Esta Seguro de eliminar la foto de perfil?',
              textAlign: TextAlign.center,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black54),
                ),
              ),
              TextButton(
                  onPressed: () {
                    _deletePhoto(context);
                  },
                  child: const Text(
                    'Confirmar',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.deepOrange),
                  ))
            ],
          );
        });
  }

  void _deletePhoto(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ));
        });

    try {
      final apiLaravel = dotenv.env['API_LARAVEL'];
      final response = await _dio.delete(
        '$apiLaravel/user-photo/${userData!.id}',
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        // print('--> RESPONSE: ${response.data}');
        _showConfirmationDialog(
          context,
          'Foto Eliminada',
          'Foto eliminada correctamente.',
        );
      } else {
        // print('--> ERROR: ${response.statusMessage}');
        final errors = response.data['errors'];
        String errorMessages = '';
        errors.forEach((key, value) {
          errorMessages += '${value[0]}\n';
        });
        _showConfirmationDialog(
          context,
          'Error',
          '${response.data['message']} : \n $errorMessages',
        );
      }
    } catch (e) {
      // print('--> ERROR: $e');
      // print('EXCEPTION AL ELIMINAR ---> $e');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Error al conectar con el servidor, intentalo nuevamente.'),
      ));
    }
  }

  void _showConfirmationDialog(
      BuildContext context, String title, String message) {
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
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete_forever),
      title: Text(
        'Eliminar Foto',
        style: GoogleFonts.titilliumWeb(fontWeight: FontWeight.w600),
      ),
      onTap: () {
        _confirmDelete(context);
      },
    );
  }
}
