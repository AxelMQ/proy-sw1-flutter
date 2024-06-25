// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../data/friendship.dart';

class ListSolicitudAmistadWidget extends StatelessWidget {
  const ListSolicitudAmistadWidget({
    Key? key,
    required List<Friendship> solicitudes,
  })  : _solicitudes = solicitudes,
        super(key: key);

  final List<Friendship> _solicitudes;

  @override
  Widget build(BuildContext context) {
    final storage = dotenv.env['STORAGE'];
    return ListView.builder(
      itemCount: _solicitudes.length,
      itemBuilder: (context, index) {
        final solicitud = _solicitudes[index];
        final userData = solicitud.user.userData;

        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProfileUserScreen(user: solicitud.user),
            //   ),
            // );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: solicitud.user.userData?.rutaFoto != null
                  ? NetworkImage(
                      '$storage/${userData!.rutaFoto}')
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
