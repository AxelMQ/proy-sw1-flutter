// ignore_for_file: file_names
import 'package:flutter/material.dart';

class FlotatingButtonWidget extends StatelessWidget {
  const FlotatingButtonWidget({
    super.key,
    required this.onStatusChanged,
  });

  final Function() onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onStatusChanged();
      },
      backgroundColor: const Color.fromARGB(255, 245, 154, 79),
      child: const Icon(
        Icons.refresh_outlined,
        color: Colors.white,
      ),
    );
  }
}
