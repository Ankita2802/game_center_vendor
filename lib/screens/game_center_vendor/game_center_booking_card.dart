import 'package:flutter/material.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';

class GameCenterBookingCard extends StatelessWidget {
  const GameCenterBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF151518),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.asset(GameCenterVendor.profile),
              title: Text(
                'Navin Sharma',
                style: onestFonts.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '60 Hz Display, 32 GB RAM',
                style: onestFonts.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF898384),
                ),
              ),
              trailing: Text(
                '₹228',
                style: onestFonts.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF898384),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'COD',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'PC',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Apr 1, 2025-',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '08:44 PM   TO   12:55 PM',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes - ',
                  style: onestFonts.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF898384),
                  ),
                ),
                Expanded(
                  child: Text(
                    maxLines: 3,
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has ',
                    style: onestFonts.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
