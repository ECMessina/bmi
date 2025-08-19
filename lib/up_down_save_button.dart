import 'package:flutter/material.dart';

class UpDownSaveButton extends StatelessWidget {
  const UpDownSaveButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
  });

  final Function() onPressed;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor, size: 30),
      tooltip: 'Save Values',
    );
  }
}
