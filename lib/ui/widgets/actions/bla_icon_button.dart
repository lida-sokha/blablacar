import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const BlaIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: BlaSize.icon,
      color: BlaColors.primary,
      style: IconButton.styleFrom(foregroundColor: BlaColors.primary),
    );
  }
}
