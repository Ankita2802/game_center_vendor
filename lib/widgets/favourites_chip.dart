import 'package:flutter/material.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class FavouriteChip extends StatelessWidget {
  final bool isFavourite;
  final VoidCallback onTap;
  const FavouriteChip({
    super.key,
    required this.isFavourite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 2, 2, 2),
      decoration: BoxDecoration(
        color: Color(0xFF21191B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Favourites',
            style: onestFonts.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Color(0xFFE8C0FD),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavourite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: Color(0xFFDF3562),
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
