import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/user.dart';
import '../../../data/user_data.dart';
import '../../../screen/EditUserDataScreen.dart';
import '../../ButtonWidget.dart';
import '../BuscadorPage/UserFriend/InfoDataProfileWidget.dart';
import 'ButtonPhotoWidget.dart';
import 'GenderIconWidget.dart';
import 'TextDataWidget.dart';

class PerfilUserWidget extends StatelessWidget {
  const PerfilUserWidget({
    super.key,
    required this.userData,
    required this.user,
  });

  final UserData? userData;
  final User? user;

  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
      return formatter.format(date);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            if (userData?.rutaFoto != null && userData!.rutaFoto!.isNotEmpty)
              Image.network(
                'http://192.168.100.2:8000/storage/${userData!.rutaFoto}',
                width: 350,
                height: 350,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              )
            else
              Image.asset(
                'assets/user_profiler.jpg',
                width: 350,
                height: 350,
              ),
            // Text('ruta_foto--> ${userData?.rutaFoto ?? ''}'),
            Text(
              '${userData?.nombre ?? ''} ${userData?.apellido ?? ''}',
              style: GoogleFonts.chakraPetch(
                  fontSize: 25, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              '@${user?.username ?? ''}',
              style: GoogleFonts.chakraPetch(
                  fontSize: 17, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            InfoDataProfileWidget(
              icon: Icons.phone,
              text: userData?.telefono ?? 'N/A',
            ),
            InfoDataProfileWidget(
              icon: Icons.email,
              text: userData?.email ?? 'N/A',
            ),
            InfoDataProfileWidget(
              iconWidget: GenderIconWidget(
                gender: userData?.sexo ?? '',
              ),
              text: userData?.sexo ?? 'N/A',
            ),
            InfoDataProfileWidget(
              icon: Icons.cake_rounded,
              text: _formatDate(userData?.fechaNac),
            ),
            // TextDataWidget(
            //   title: 'Telefono: ',
            //   textData: userData?.telefono ?? '',
            // ),
            // TextDataWidget(
            //   title: 'Email: ',
            //   textData: userData?.email ?? '',
            // ),
            // TextDataWidget(
            //   title: 'Sexo: ',
            //   textData: userData?.sexo ?? '',
            // ),
            // TextDataWidget(
            //   title: 'Fecha: ',
            //   textData: _formatDate(userData?.fechaNac),
            // ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  backgroundColor: Colors.black38,
                  text: 'Editar Informacion',
                  onTap: () {
                    // print('EDITAR INFORMACION');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserDataScreen(
                                userData: userData,
                                user: user,
                              )),
                    );
                  },
                ),
                const SizedBox(width: 20),
                ButtonPhotoWidget(userData: userData),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
