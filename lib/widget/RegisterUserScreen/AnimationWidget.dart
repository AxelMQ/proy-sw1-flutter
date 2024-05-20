// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatelessWidget {
  final String path;
  const AnimationWidget({
    super.key, required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Lottie.asset(path),
      ),
    );
  }
}
