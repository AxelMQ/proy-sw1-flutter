// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proy_sw1/data/user_data.dart';
import '../../../../screen/HomeScreen.dart';
import '../../../ButtonWidget.dart';
import '../../../MessageDialogWidget.dart';
import 'OptionDeletePhotoWidget.dart';

class ButtonPhotoWidget extends StatelessWidget {
  final UserData? userData;
  final Dio _dio = Dio();

  ButtonPhotoWidget({
    super.key,
    this.userData,
  });
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);

  Future<void> _pickAndCropImage(
      {required ImageSource source, required BuildContext context}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        _imageNotifier.value = croppedFile;
        await _updatePhoto(context);
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Imagen',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Recortar Imagen',
        ),
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  Future<void> _updatePhoto(BuildContext context) async {
    try {
      if (_imageNotifier.value != null) {
        final File imageFile = _imageNotifier.value!;
        // print('${imageFile.path}');
        if (imageFile.existsSync()) {
          // Verifica si el archivo de imagen existe
          FormData formData = FormData.fromMap({
            'ruta_foto': await MultipartFile.fromFile(imageFile.path),
          });

          final apiLaravel = dotenv.env['API_LARAVEL'];
          final response = await _dio.post(
            '$apiLaravel/user-photo/${userData!.id}',
            data: formData,
            options: Options(
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );
          if (response.statusCode == 200) {
            print('--> RESPONSE: ${response.data}');
            _showConfirmationDialog(
                context, 'Foto Actualizada', 'Foto actualizada correctamente.');
          } else {
            print('--> ERROR: ${response.statusMessage}');
            final errors = response.data['errors'];
            String errorMessages = '';
            errors.forEach((key, value) {
              errorMessages += '${value[0]}\n';
            });
            _showConfirmationDialog(context, 'Error',
                '${response.data['message']} : \n $errorMessages');
          }
        } else {
          print('El archivo de imagen no existe');
        }
      } else {
        print('No hay imagen seleccionada');
      }
    } catch (e) {
      print('--> ERROR: $e');
      print('EXCEPTION AL ACTUALIZAR ---> $e');
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
    return ValueListenableBuilder<File?>(
      valueListenable: _imageNotifier,
      builder: (context, imageFile, child) {
        return Column(
          children: [
            ButtonWidget(
              backgroundColor: Colors.black38,
              text: 'Cambiar foto',
              onTap: () {
                _showPhotoOptions(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showPhotoOptions(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Tomar una foto',
                  style: GoogleFonts.titilliumWeb(fontWeight: FontWeight.w600),
                ),
                onTap: () => _pickAndCropImage(
                    source: ImageSource.camera, context: context),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Elegir de la galería',
                  style: GoogleFonts.titilliumWeb(fontWeight: FontWeight.w600),
                ),
                onTap: () => _pickAndCropImage(
                    source: ImageSource.gallery, context: context),
              ),
              if (userData?.rutaFoto != null && userData!.rutaFoto!.isNotEmpty)
                OptionDeletePhotoWidget(userData: userData),
            ],
          ),
        );
      },
    );
  }
}
