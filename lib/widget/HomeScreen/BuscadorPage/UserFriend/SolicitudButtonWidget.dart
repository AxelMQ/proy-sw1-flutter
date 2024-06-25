// ignore_for_file: use_build_context_synchronously, file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/widget/HomeScreen/BuscadorPage/UserFriend/publicFriendWidget.dart';
import '../../../../data/user.dart';
import '../../../../service/storage_service.dart';
import '../../../ButtonIconWidget.dart';

class SolicitudButtonWidget extends StatefulWidget {
  const SolicitudButtonWidget({
    super.key,
    this.user,
    required this.onStatusChanged, 
    required this.publicFriendKey,
  });

  final User? user;
  final Function() onStatusChanged;
  final GlobalKey<PublicFriendWidgetState> publicFriendKey;

  @override
  State<SolicitudButtonWidget> createState() => _SolicitudButtonWidgetState();
}

class _SolicitudButtonWidgetState extends State<SolicitudButtonWidget> {
  final Dio _dio = Dio();
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user!;
  }

  Future<void> handleSolicitud(BuildContext context, int friendId,
      String action, String successMessage) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        });

    String url = '';
    final apiLaravel = dotenv.env['API_LARAVEL'];
    switch (action) {
      case 'send':
        url = '$apiLaravel/send-solicitud/$friendId';
        break;
      case 'accept':
        url = '$apiLaravel/aceptar-solicitud/$friendId';
        break;
      case 'cancel':
        url = '$apiLaravel/cancelar-solicitud/$friendId';
        break;
      case 'rechazar':
        url = '$apiLaravel/rechazar-solicitud/$friendId';
        break;
      case 'delete':
        url = '$apiLaravel/delete-friends/$friendId';
        break;
      default:
        Navigator.of(context).pop();
        return;
    }

    try {
      String? token = await StorageService.getToken();
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print('Status code: ${response.statusCode}');
      print('Status message: ${response.statusMessage}');
      print('Response data: ${response.data}');

      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        // print(successMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 67, 163, 117),
            content: Text(
              successMessage,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        );
        setState(
          () {
            _user = _user.copyWith(relationStatus: _getNewStatus(action));
          },
        );
        widget.onStatusChanged();
        widget.publicFriendKey.currentState?.refreshFriendsCount();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Error al procesar la solicitud.',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    } catch (e) {
      // print('--> ERROR: $e');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Error al procesar la solicitud.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  String? _getNewStatus(String action) {
    switch (action) {
      case 'send':
        return 'pending_sent';
      case 'accept':
        return 'aceptado';
      case 'cancel':
        return 'default';
      case 'rechazar':
        return 'rechazado';
      case 'delete':
        return 'default';
      default:
        return _user.relationStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    Color color = Colors.black;
    final Function()? onTap;
    IconData iconData = Icons.person_add;

    switch (_user.relationStatus) {
      case 'pending_received':
        text = 'Confirmar Solicitud';
        color = Colors.blueGrey;
        iconData = Icons.notifications;
        onTap = () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(
                        'Confirmar Solicitud',
                        style: GoogleFonts.titilliumWeb(
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        handleSolicitud(context, _user.id, 'accept',
                            'Solicitud de amistad aceptada exitosamente.');
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.cancel),
                      title: Text(
                        'Rechazar Solicitud',
                        style: GoogleFonts.titilliumWeb(
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        handleSolicitud(context, _user.id, 'rechazar',
                            'Solicitud Rechazada.');
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              );
            },
          );
          print('-->ACEPTAR SOLICITUD?');
        };
        break;
      case 'pending_sent':
        text = 'Solicitud pendiente';
        color = const Color.fromARGB(255, 119, 118, 118);
        iconData = Icons.pending;
        onTap = () {
          print('-->SOLICITUD PENDIENTE');
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.cancel),
                      title: Text(
                        'Cancelar Solicitud',
                        style: GoogleFonts.titilliumWeb(
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        handleSolicitud(context, _user.id, 'cancel',
                            'Solicitud cancelada.');
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              );
            },
          );
        };
        break;
      case 'aceptado':
        text = 'Amigos';
        color = const Color.fromARGB(255, 67, 189, 130);
        iconData = Icons.check;
        onTap = () {
          print('-->Amigos');
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.person_off_rounded),
                      title: Text(
                        'Eliminar Amigo',
                        style: GoogleFonts.titilliumWeb(
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        handleSolicitud(context, _user.id, 'delete',
                            'Amigo eliminado exitosamente.');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        };
        break;
      case 'rechazado':
        text = 'Rechazado';
        color = Colors.red;
        iconData = Icons.cancel;
        onTap = () {
          print('-->Rechazado');
        };
        break;
      case 'Mi perfil':
        text = 'Mi perfil';
        color = Colors.blue;
        iconData = Icons.person;
        onTap = () {
          print('-->Mi Perfil');
        };
        break;
      default:
        text = 'Agregar Amigo';
        color = Colors.blueAccent;
        iconData = Icons.person_add;
        onTap = () {
          handleSolicitud(context, _user.id, 'send',
              'Solicitud de amistad enviada exitosamente.');
          print('-->Agregar Amigo');
        };
        break;
    }
    return ButtonIconWidget(
      text: text,
      buttonColor: color,
      icon: iconData,
      onTap: onTap,
    );
  }
}
