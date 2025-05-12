import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';

class FacilitiesTab extends StatelessWidget {
  const FacilitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              tilePadding: EdgeInsets.symmetric(),
              shape: Border.all(color: Colors.transparent),
              leading: SvgPicture.asset(GameCenterImgs.food),
              title: Text(
                "Food Cafe",
                style: onestFonts.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFBCB8B8),
                ),
              ),
              children: [Image.asset(GameCenterImgs.foodMenu)],
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.symmetric(),
              shape: Border.all(color: Colors.transparent),
              leading: SvgPicture.asset(GameCenterImgs.coldDrink),
              title: Text(
                "Cold Drinks",
                style: onestFonts.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFBCB8B8),
                ),
              ),
              children: [Image.asset(GameCenterImgs.foodMenu)],
            ),
          ],
        ),
      ),
    );
  }
}
