import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proy_sw1/screen/EditUserDataScreen.dart';
import 'package:proy_sw1/widget/ButtonWidget.dart';

import '../../data/user.dart';
import '../../data/user_data.dart';
import '../../widget/HomeScreen/PerfilDataWidget.dart';

class PerfilPageScreen extends StatelessWidget {
  final User? user;
  final UserData? userData;

  const PerfilPageScreen({super.key, this.user, this.userData});
  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
      return formatter.format(date);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text('Perfil'),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
              ),
              Text(
                '@${user?.username ?? ''}',
                style: GoogleFonts.chakraPetch(
                    fontSize: 17, fontWeight: FontWeight.w300),
              ),
              const Divider(),
              PerfilDataWidget(
                title: 'Telefono: ',
                textData: userData?.telefono ?? '',
              ),
              PerfilDataWidget(
                title: 'Email: ',
                textData: userData?.email ?? '',
              ),
              PerfilDataWidget(
                title: 'Sexo: ',
                textData: userData?.sexo ?? '',
              ),
              PerfilDataWidget(
                title: 'Fecha: ',
                textData: _formatDate(userData?.fechaNac),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    backgroundColor: Colors.black38,
                    text: 'Editar Informacion',
                    onTap: () {
                      print('EDITAR INFORMACION');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserDataScreen(userData: userData)),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  const ButtonWidget(
                      backgroundColor: Colors.black38, text: 'Cambiar foto'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
