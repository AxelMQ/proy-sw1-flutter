// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../data/user.dart';
import '../../../data/user_data.dart';
import '../BuscadorPage/UserFriend/publicFriendWidget.dart';

class PhotoPublicFriendWidget extends StatefulWidget {
  const PhotoPublicFriendWidget({
    super.key,
    required this.userData,
    required this.user,
    required this.onStatusChanged,
    required this.publicFriendKey,
  });

  final UserData? userData;
  final User? user;
  final Function() onStatusChanged;
  final GlobalKey<PublicFriendWidgetState> publicFriendKey;

  @override
  State<PhotoPublicFriendWidget> createState() => _PhotoPublicFriendWidgetState();
}

class _PhotoPublicFriendWidgetState extends State<PhotoPublicFriendWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: widget.userData?.rutaFoto != null
              ? NetworkImage(
                  'http://192.168.100.2:8000/storage/${widget.userData!.rutaFoto}')
              : const AssetImage('assets/user_profiler.jpg')
                  as ImageProvider,
          radius: 85,
        ),
        const SizedBox(width: 20),
        publicFriendWidget(
          key: widget.publicFriendKey,
          user: widget.user!,
          onStatusChanged: widget.onStatusChanged,
        ),
      ],
    );
  }
}
