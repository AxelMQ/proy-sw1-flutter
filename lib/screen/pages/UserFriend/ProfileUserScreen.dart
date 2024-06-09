// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../data/user.dart';

class ProfileUserScreen extends StatelessWidget {
  final User user;

  const ProfileUserScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final userData = user.userData;

    return Scaffold(
      appBar: AppBar(
        title: Text('@${user.username}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userData?.rutaFoto != null)
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://192.168.100.2:8000/storage/${userData!.rutaFoto}'),
                radius: 60,
              ),
            const SizedBox(height: 16),
            Text('Nombre: ${userData?.nombre ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            Text('Apellido: ${userData?.apellido ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            Text('Teléfono: ${userData?.telefono ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            Text('Email: ${userData?.email ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
            Text('Fecha de Nacimiento: ${userData?.fechaNac ?? 'N/A'}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
