import 'package:flutter/material.dart';

class TabChip extends StatelessWidget {
  final bool selected;
  const TabChip({
    super.key,
    required this.label,
    required this.onTap,
    required this.selected,
    this.icon,
  });
  final String label;
  final VoidCallback onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(1, 0, 1, 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient:
              !selected
                  ? null
                  : LinearGradient(
                    colors: [
                      Color(0x00FFFFFF),
                      Colors.white,
                      Color(0x00FFFFFF),
                    ],
                    begin: AlignmentDirectional.bottomStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: selected ? Colors.black : Colors.transparent,
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 100),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient:
                  !selected
                      ? null
                      : LinearGradient(
                        colors: [Color(0x00622483), Color(0xFFAE40E9)],
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                      ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) SizedBox(width: 7),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: selected ? Color(0xFFE8C0FD) : Color(0xFFBCB8B8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
