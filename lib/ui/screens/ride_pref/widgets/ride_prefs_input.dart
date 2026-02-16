import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_icon_button.dart';

class RidePrefInput extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;
  final bool isPlaceHolder;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInput({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.isPlaceHolder = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(leftIcon, size: BlaSize.icon, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: BlaTextStyles.button.copyWith(
                  fontSize: 14,
                  color: isPlaceHolder
                      ? BlaColors.textLight
                      : BlaColors.textNormal,
                ),
              ),
            ),
            if (rightIcon != null)
              BlaIconButton(
                icon: rightIcon!,
                onPressed: onRightIconPressed ?? () {},
              ),
          ],
        ),
      ),
    );
  }
}
