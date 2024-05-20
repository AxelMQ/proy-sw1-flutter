import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'IconButtonWidget.dart';

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({
    super.key,
    required this.imageNotifier,
  });

  final ValueNotifier<File?> imageNotifier;

  // Método para seleccionar y recortar una imagen
  Future<void> _pickAndCropImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        imageNotifier.value = croppedFile;
      }
    }
  }

  // Método para eliminar la imagen seleccionada
  void _removeImage() {
    imageNotifier.value = null;
  }

  // Método para recortar la imagen
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: imageNotifier,
      builder: (context, imageFile, child) {
        return Column(
          children: [
            imageFile != null
                ? Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                    height: 300,
                  )
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey,
                    child: const Icon(
                      Icons.person_4_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButtonWidget(
                  onTap: () => _pickAndCropImage(source: ImageSource.gallery),
                  color: Colors.blueGrey,
                  icon: Icons.photo,
                ),
                if (imageFile != null)
                  IconButtonWidget(
                    onTap: _removeImage,
                    color: Colors.deepOrange,
                    icon: Icons.delete_forever_sharp,
                  ),
                IconButtonWidget(
                  onTap: () => _pickAndCropImage(source: ImageSource.camera),
                  color: Colors.blueGrey,
                  icon: Icons.camera_alt,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
