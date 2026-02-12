import 'package:flutter/widgets.dart';

enum BlaButtonType {
    primary,
    secondary,
}

class BlaButton extends StatelessWidget {
    final String label;
    final BlaButtonType type;
    final IconData ? icon;
    final VoidCallback ? onPressed;

    const BlaButton({
        super.key,
        required this.label,
        this.type = BlaButtonType.primary,
        this.icon,
        required this.onPressed,
    });

    @override
    Widget build(BuildContext context) {
        final bool isPrimary = type == BlaButtonType.primary;
        final Color backgroundColor = isPrimary ? Colors.blue: Colors.white;
        final Color textColor = isPrimary ? Colors.white: Colors.blue;
        final BorderSide border = isPrimary ? BorderSide.none : BorderSide(color: Colors.blue);

        return SizeBox(
            height: 48,
            child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: textColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: border,
                    ),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        if (icon != null) ...[
                            Icon(icon, size: 20),
                            SizedBox(width: 8),
                        ],
                        Text(label, style: TextStyle(fontSize: 16)),
                    ],
                )
            )
        );
    }
}