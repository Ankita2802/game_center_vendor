import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_booking_card.dart';
import 'package:game_center_vendor/themes/app_font.dart';
import 'package:game_center_vendor/themes/app_images.dart';

class GameCenterBooking extends StatefulWidget {
  const GameCenterBooking({super.key});

  @override
  State<GameCenterBooking> createState() => _GameCenterBookingState();
}

class _GameCenterBookingState extends State<GameCenterBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          'Game Center Bookings',
          style: onestFonts.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        leadingWidth: 60,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(SvgIcons.appbarBack),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(SvgIcons.search),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GameCenterBookingCard(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
