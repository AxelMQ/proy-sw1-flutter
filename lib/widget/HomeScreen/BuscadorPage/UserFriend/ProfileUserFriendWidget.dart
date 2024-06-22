// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/widget/HomeScreen/PerfilPage/PhotoPublicFriendWidget.dart';
import '../../../../data/user.dart';
import '../../../../data/user_data.dart';
import '../../PerfilPage/IconDataProfileWidget.dart';
import 'SolicitudButtonWidget.dart';
import 'publicFriendWidget.dart';

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

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PublicFriendWidgetState> publicFriendKey =
        GlobalKey<PublicFriendWidgetState>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoPublicFriendWidget(
            userData: userData,
            user: user,
            onStatusChanged: onStatusChanged,
            publicFriendKey: publicFriendKey,
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
          const Divider(
            height: 10,
            thickness: 1.5,
            endIndent: 20,
            indent: 0,
          ),
          IconDataProfileWidget(userData: userData),
          const SizedBox(height: 15),
          SolicitudButtonWidget(
              user: user,
              publicFriendKey: publicFriendKey,
              onStatusChanged: () {
                onStatusChanged();
                publicFriendKey.currentState?.refreshFriendsCount();
              }),
        ],
      ),
    );
  }
}
