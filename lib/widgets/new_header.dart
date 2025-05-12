import 'package:flutter/material.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class NewHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String? buttonLabel;
  final TextStyle? headerStyle;
  final bool arrow;
  const NewHeader({
    super.key,
    required this.title,
    this.onTap,
    this.buttonLabel,
    this.arrow = true,
    this.headerStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                headerStyle ??
                onestFonts.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      buttonLabel ?? 'See all',
                      style: onestFonts.copyWith(
                        fontSize: 12,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),
                    if (arrow) SizedBox(width: 6),
                    if (arrow) Icon(Icons.add, size: 10),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
