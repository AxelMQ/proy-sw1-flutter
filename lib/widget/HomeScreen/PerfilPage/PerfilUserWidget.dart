// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/widget/HomeScreen/BuscadorPage/UserFriend/publicFriendWidget.dart';
import '../../../data/user.dart';
import '../../../data/user_data.dart';
import '../../../screen/EditUserDataScreen.dart';
import '../../ButtonWidget.dart';
import 'ButtonPhotoWidget.dart';
import 'IconDataProfileWidget.dart';
import 'PhotoPublicFriendWidget.dart';

class PerfilUserWidget extends StatelessWidget {
  const PerfilUserWidget({
    super.key,
    required this.userData,
    required this.user,
    required this.onStatusChanged,
  });

  final UserData? userData;
  final User? user;
  final Function() onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PublicFriendWidgetState> publicFriendKey =
        GlobalKey<PublicFriendWidgetState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPublicFriendWidget(
              userData: userData,
              user: user,
              onStatusChanged: onStatusChanged,
              publicFriendKey: publicFriendKey,
            ),
            Text(
              '${userData?.nombre ?? ''} ${userData?.apellido ?? ''}',
              style: GoogleFonts.chakraPetch(
                  fontSize: 25, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              '@${user?.username ?? ''}',
              style: GoogleFonts.chakraPetch(
                  fontSize: 17, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            IconDataProfileWidget(userData: userData),
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
                    ).then((_) => onStatusChanged());
                  },
                ),
                const SizedBox(width: 20),
                ButtonPhotoWidget(userData: userData),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
