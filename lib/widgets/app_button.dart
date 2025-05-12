import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onTap,
    required this.text,
    this.fontSize = 14,
    this.arrow = true,
    this.iosArrow = false,
    this.padding,
    this.textColor,
    this.icon,
  });
  final VoidCallback onTap;
  final String text;
  final double fontSize;
  final bool arrow;
  final bool iosArrow;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return NeoPopButton(
      buttonPosition: Position.bottomCenter,
      bottomShadowColor: Color(0xFF7349C7),
      onTapUp: onTap,
      depth: 4,
      color: Colors.white,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor ?? Color(0xFF232323),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[SizedBox(width: 8), icon!],
            if (icon == null) ...[
              if (arrow || iosArrow) SizedBox(width: 8),
              if (!iosArrow)
                if (arrow) SvgPicture.asset(SvgIcons.buttonArrow),
              if (iosArrow)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF050101),
                  size: 12,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
