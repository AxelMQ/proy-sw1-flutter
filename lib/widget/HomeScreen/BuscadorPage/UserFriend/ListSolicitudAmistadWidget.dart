// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/pages/UserFriend/ProfileUserScreen.dart';
import '../../../../data/friendship.dart';

class ListSolicitudAmistadWidget extends StatelessWidget {
  const ListSolicitudAmistadWidget({
    super.key,
    required List<Friendship> solicitudes,
  }) : _solicitudes = solicitudes;

  final List<Friendship> _solicitudes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _solicitudes.length,
      itemBuilder: (context, index) {
        final solicitud = _solicitudes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUserScreen(user: solicitud.user),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: solicitud.user.userData?.rutaFoto != null
                  ? NetworkImage(
                      'http://192.168.100.2:8000/storage/${solicitud.user.userData!.rutaFoto}')
                  : const AssetImage('assets/user_profiler.jpg')
                      as ImageProvider,
            ),
            title: Text(solicitud.user.username),
            subtitle: Text(solicitud.estado),
            trailing: IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                // Acción para aceptar la solicitud de amistad
                print('Aceptar solicitud de: ${solicitud.user.username}');
              },
            ),
          ),
        );
      },
    );
  }
}
