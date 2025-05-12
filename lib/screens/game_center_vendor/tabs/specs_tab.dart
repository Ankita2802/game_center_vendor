import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';

class SpecsTab extends StatelessWidget {
  const SpecsTab({super.key});

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
                  "PC Specs",
                  style: onestFonts.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 0.2,
                  color: Color(0xFF726C6C),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "60 Hz Display, 32 GB RAM",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹199",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Text(
                    "4 Slots",
                    style: onestFonts.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF898384),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "PC Specs",
                    style: onestFonts.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF898384),
                    ),
                  ),
                  SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "90 Hz Display, 32 GB RAM",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹229",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "PC Specs",
                    style: onestFonts.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF898384),
                    ),
                  ),
                  SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "120 Hz Display, 32 GB RAM",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹349",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                  "Console Specs",
                  style: onestFonts.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 0.2,
                  color: Color(0xFF726C6C),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PS 5 - 144 Hz Display",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹199",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Text(
                    "3 Slots",
                    style: onestFonts.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF898384),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PS 4 - 90 Hz Display",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹229",
                        style: onestFonts.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Text(
                    "4 Slots",
                    style: onestFonts.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF898384),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
