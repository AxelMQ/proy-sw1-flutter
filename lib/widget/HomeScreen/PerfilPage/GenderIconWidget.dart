// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GenderIconWidget extends StatelessWidget {
  final String? gender;

  const GenderIconWidget({Key? key, this.gender}) : super(key: key);

  IconData _getGenderIcon(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'masculino':
        return Icons.male;
      case 'femenino':
        return Icons.female;
      case 'otro':
        return Icons.transgender;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getGenderIcon(gender),
      size: 18,
    );
  }
}
