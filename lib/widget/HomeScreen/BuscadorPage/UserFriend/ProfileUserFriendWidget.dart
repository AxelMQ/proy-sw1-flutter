// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../data/user.dart';
import '../../../../data/user_data.dart';
import '../../PerfilPage/GenderIconWidget.dart';
import 'InfoDataProfileWidget.dart';
import 'SolicitudButtonWidget.dart';

class ProfileUserFriendWidget extends StatelessWidget {
  const ProfileUserFriendWidget({
    super.key,
    required this.userData,
    this.user,
    required this.onStatusChanged,
  });

  final UserData? userData;
  final User? user;
  final Function() onStatusChanged;

  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
      return formatter.format(date);
    }
    return 'N/A';
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
            iconWidget: GenderIconWidget(gender: userData?.sexo ?? '',),
            text: userData?.sexo ?? 'N/A',
          ),
          InfoDataProfileWidget(
            icon: Icons.cake_rounded,
            text: _formatDate(userData?.fechaNac),
          ),
          const SizedBox(height: 15),
          SolicitudButtonWidget(
            user: user,
            onStatusChanged: onStatusChanged,
          ),
        ],
      ),
    );
  }
}
