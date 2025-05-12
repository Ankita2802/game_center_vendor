import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_card.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';

class GamesAvailableTab extends StatelessWidget {
  const GamesAvailableTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  GameCenterImgs.computer,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "PC Games",
                  style: onestFonts.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            GamesCardList(),
            SizedBox(height: 24),
            Row(
              children: [
                SvgPicture.asset(
                  GameCenterImgs.gameController,
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 10),
                Text(
                  "Console Games",
                  style: onestFonts.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            GamesCardList(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
