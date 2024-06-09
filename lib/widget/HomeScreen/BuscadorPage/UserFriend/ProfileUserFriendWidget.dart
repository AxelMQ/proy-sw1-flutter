// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proy_sw1/service/storage_service.dart';
import '../../../../data/user_data.dart';
import '../../../ButtonIconWidget.dart';
import 'InfoDataProfileWidget.dart';

class ProfileUserFriendWidget extends StatelessWidget {
  ProfileUserFriendWidget({
    super.key,
    required this.userData,
  });

  final UserData? userData;
  final Dio _dio = Dio();

  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
      return formatter.format(date);
    }
    return 'N/A';
  }

  Future<void> sendSolicitud(int friendId) async {
    try {
      String? token = await StorageService.getToken();
      final response = await _dio.post(
        'http://192.168.100.2:8000/api/send-solicitud/$friendId',
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
      // print(response.data);
      if (response.statusCode == 200) {
        print('Solicitud de amistad enviada.');
      } else {
        print('Error al enviar la solicitud de amistad.');
      }
    } catch (e) {
      print('--> ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Text(
            '${userData?.nombre ?? 'N/A'} ${userData?.apellido ?? 'N/A'}',
            style: GoogleFonts.titilliumWeb(
                fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 5),
          InfoDataProfileWidget(
            icon: Icons.phone,
            text: userData?.telefono ?? 'N/A',
          ),
          InfoDataProfileWidget(
            icon: Icons.email,
            text: userData?.email ?? 'N/A',
          ),
          InfoDataProfileWidget(
            icon: Icons.cake_rounded,
            text: _formatDate(userData?.fechaNac),
          ),
          const SizedBox(height: 15),
          ButtonIconWidget(
            text: 'Enviar Solicitud',
            onTap: () {
              if (userData != null) {
                print('---> ENVIAR SOLICITUD... ${userData!.userId}');
                sendSolicitud(userData!.userId);
              } else {
                print('--> USER DATA US NULL');
              }
            },
          )
        ],
      ),
    );
  }
}
