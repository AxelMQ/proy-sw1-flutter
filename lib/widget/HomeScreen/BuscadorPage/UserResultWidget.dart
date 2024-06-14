// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:proy_sw1/screen/pages/UserFriend/ProfileUserScreen.dart';

class UserResultWidget extends StatefulWidget {
  const UserResultWidget({
    super.key,
    required this.userData,
    required this.user,
    required this.onStatusChanged,
  });

  final userData;
  final user;
  final Function() onStatusChanged;

  @override
  State<UserResultWidget> createState() => _UserResultWidgetState();
}

class _UserResultWidgetState extends State<UserResultWidget> {
  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.person_add;
    Color iconColor = Colors.grey;
    Function() onTap = () {};
    switch (widget.user.relationStatus) {
      case 'Mi perfil':
        iconData = Icons.person;
        iconColor = Colors.blue;
        onTap = () {
          print('MI PERFIL');
        };
        break;
      case 'pending_received':
        iconData = Icons.notification_important_sharp;
        iconColor = const Color.fromARGB(255, 18, 144, 202);
        onTap = () {
          print('Pendiente - Recibido');
        };
        break;
      case 'pending_sent':
        iconData = Icons.pending;
        iconColor = Colors.grey;
        onTap = () {
          print('Pendiente - Enviado');
        };
        break;
      case 'aceptado':
        iconData = Icons.check;
        iconColor = Colors.green;
        onTap = () {
          print('aceptado...');
        };
        break;
      case 'rechazado':
        iconData = Icons.cancel;
        iconColor = Colors.red;
        onTap = () {
          print('rechazado...');
        };
        break;
      default:
        onTap = () {
          print('Default case');
        };
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileUserScreen(
              user: widget.user,
              onStatusChanged: widget.onStatusChanged,
            ),
          ),
        );
      },
      child: ListTile(
        leading: widget.userData?.rutaFoto != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://192.168.100.2:8000/storage/${widget.userData!.rutaFoto}'),
              )
            : CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text(
                  widget.user.username[0].toUpperCase(),
                ),
              ),
        title: Text('@${widget.user.username}'),
        subtitle:
            widget.userData != null ? Text(widget.user.relationStatus) : null,
        trailing: Icon(iconData, color: iconColor)
      ),
    );
  }
}
