// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/user_data.dart';
import '../BuscadorPage/UserFriend/InfoDataProfileWidget.dart';
import 'GenderIconWidget.dart';

class IconDataProfileWidget extends StatelessWidget {
  const IconDataProfileWidget({
    super.key,
    required this.userData,
  });

  final UserData? userData;

  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy'); // Formato deseado
      return formatter.format(date);
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
