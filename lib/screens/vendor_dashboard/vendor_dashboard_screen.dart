import 'package:flutter/material.dart';
import 'package:game_center_vendor/screens/game_center_add/add_game_center.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';
import 'package:game_center_vendor/widgets/app_button.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0A0A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF0A0A0A),
        title: Image.asset(GameCenterVendor.playverse, width: 100),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                GameCenterVendor.profile,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(GameCenterVendor.noGame, height: 100, width: 100),
            const SizedBox(height: 24),
            Text(
              'No Game Center found',
              textAlign: TextAlign.center,
              style: onestFonts.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You don’t have any Game Center yet. Add one now to register in Playverse.',
              textAlign: TextAlign.center,
              style: onestFonts.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0XFFBCB8B8),
              ),
            ),
            const Spacer(),
            AuthButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEditGameScreen()),
                );
              },
              text: 'Add Game Center',
              arrow: false,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
