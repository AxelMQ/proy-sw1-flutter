import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final Color? color;

  const IconButtonWidget({
    super.key,
    this.onTap,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 30),
    );
  }
}
